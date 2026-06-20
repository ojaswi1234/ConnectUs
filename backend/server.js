import express from 'express';
import { createYoga, createSchema } from 'graphql-yoga';
import { createServer } from 'http';
import { WebSocketServer } from 'ws';
import { useServer } from 'graphql-ws/use/ws';
import { createPubSub } from 'graphql-yoga';
import pg from 'pg';
import jwt from 'jsonwebtoken';

const pubsub = createPubSub();
const { Pool } = pg;

// Postgres connection
const pool = new Pool({
  connectionString: process.env.DATABASE_URL || 'postgres://postgres:postgres@localhost:5432/postgres',
  ssl: process.env.DATABASE_URL ? { rejectUnauthorized: false } : false
});

// API Keys & Secrets
const GROQ_API_KEY = process.env.GROQ_API_KEY;
const SUPABASE_JWT_SECRET = process.env.SUPABASE_JWT_SECRET || 'super-secret-jwt-token-with-at-least-32-characters-long';

// Auth Middleware context
const getContext = async ({ req, connectionParams }) => {
  let token = null;
  if (req && req.headers.authorization) {
    token = req.headers.authorization.split(' ')[1];
  } else if (connectionParams && connectionParams.Authorization) {
    token = connectionParams.Authorization.split(' ')[1];
  }

  let user = null;
  if (token) {
    try {
      const decoded = jwt.verify(token, SUPABASE_JWT_SECRET);
      user = { id: decoded.sub, ...decoded };
    } catch (e) {
      console.error("JWT Verify Error:", e.message);
    }
  }
  return { user };
};

const typeDefs = `
  type Message {
    id: ID!
    roomId: String!
    senderId: String!
    user: String!
    text: String!
    createdAt: String!
  }

  type UserSearchResult {
    id: ID!
    username: String!
    phoneNumber: String
    isOnline: Boolean!
  }

  enum Platform { MOBILE WEB }

  enum CallSignalType { OFFER ANSWER ICE_CANDIDATE HANGUP }

  type CallSignal {
    roomId: String!
    senderId: String!
    type: CallSignalType!
    payload: String!
  }

  type Query {
    messages(roomId: String!, after: String): [Message!]!
    searchUsers(query: String!, platform: Platform!): [UserSearchResult!]!
  }

  type Mutation {
    postMessage(roomId: String!, user: String!, text: String!): Message!
    sendCallSignal(roomId: String!, type: CallSignalType!, payload: String!): Boolean!
    askAssistant(prompt: String!): String!
  }

  type Subscription {
    messages(roomId: String!): Message!
    callSignals(roomId: String!): CallSignal!
  }
`;

const resolvers = {
  Query: {
    messages: async (_, { roomId, after }, context) => {
      if (!context.user) throw new Error("Unauthorized");
      let query = "SELECT * FROM chat_messages WHERE room_id = $1";
      let values = [roomId];
      if (after) {
        query += " AND created_at > $2";
        values.push(after);
      }
      query += " ORDER BY created_at ASC";
      
      const res = await pool.query(query, values);
      return res.rows.map(r => ({
        id: r.id,
        roomId: r.room_id,
        senderId: r.sender_id,
        user: r.sender_username,
        text: r.content,
        createdAt: r.created_at.toISOString()
      }));
    },
    searchUsers: async (_, { query, platform }, context) => {
      if (!context.user) throw new Error("Unauthorized");
      let sql = "";
      let values = [];
      if (platform === "MOBILE") {
        sql = "SELECT id, usrname, phone_number, is_online FROM users WHERE usrname ILIKE $1 OR phone_number = $2";
        values = [`%${query}%`, query];
      } else {
        sql = "SELECT id, usrname, is_online FROM users WHERE usrname ILIKE $1";
        values = [`%${query}%`];
      }
      const res = await pool.query(sql, values);
      return res.rows.map(r => ({
        id: r.id,
        username: r.usrname,
        phoneNumber: platform === "MOBILE" ? r.phone_number : null,
        isOnline: r.is_online || false
      }));
    }
  },
  Mutation: {
    postMessage: async (_, { roomId, user, text }, context) => {
      if (!context.user) throw new Error("Unauthorized");
      const senderId = context.user.id;
      
      const uRes = await pool.query("SELECT usrname FROM users WHERE id = $1", [senderId]);
      if (uRes.rowCount === 0) throw new Error("User not found");
      const realUser = uRes.rows[0].usrname;

      const res = await pool.query(
        "INSERT INTO chat_messages (room_id, sender_id, sender_username, content) VALUES ($1, $2, $3, $4) RETURNING *",
        [roomId, senderId, realUser, text]
      );
      
      const r = res.rows[0];
      const msg = {
        id: r.id,
        roomId: r.room_id,
        senderId: r.sender_id,
        user: r.sender_username,
        text: r.content,
        createdAt: r.created_at.toISOString()
      };
      
      pubsub.publish(`MSG_UPDATE:${roomId}`, msg);
      return msg;
    },
    sendCallSignal: async (_, { roomId, type, payload }, context) => {
      if (!context.user) throw new Error("Unauthorized");
      const signal = {
        roomId,
        senderId: context.user.id,
        type,
        payload
      };
      pubsub.publish(`CALL_${roomId}`, signal);
      return true;
    },
    askAssistant: async (_, { prompt }, context) => {
      if (!context.user) throw new Error("Unauthorized");
      if (!GROQ_API_KEY) throw new Error("Groq API key not configured on server");
      
      try {
        const response = await fetch("https://api.groq.com/openai/v1/chat/completions", {
          method: "POST",
          headers: {
            "Authorization": `Bearer ${GROQ_API_KEY}`,
            "Content-Type": "application/json"
          },
          body: JSON.stringify({
            model: "llama-3.3-70b-versatile",
            messages: [
              { role: "system", content: "You are Connectify, a chatty chatbot." },
              { role: "user", content: prompt }
            ]
          })
        });
        const data = await response.json();
        return data.choices[0].message.content;
      } catch (e) {
        return "Error calling Groq API: " + e.message;
      }
    }
  },
  Subscription: {
    messages: {
      subscribe: (_, { roomId }) => pubsub.subscribe(`MSG_UPDATE:${roomId}`),
      resolve: (payload) => payload
    },
    callSignals: {
      subscribe: (_, { roomId }) => pubsub.subscribe(`CALL_${roomId}`),
      resolve: (payload) => payload
    }
  }
};

const schema = createSchema({ typeDefs, resolvers });

const app = express();
const httpServer = createServer(app);

const yoga = createYoga({
  schema,
  graphqlEndpoint: '/graphql',
  context: getContext,
  graphiql: { subscriptionsProtocol: 'WS' }
});

const wsServer = new WebSocketServer({
  server: httpServer,
  path: yoga.graphqlEndpoint,
});

useServer({ 
  schema, 
  context: (ctx) => getContext({ connectionParams: ctx.connectionParams })
}, wsServer);

app.use(yoga.graphqlEndpoint, yoga);

let PORT = process.env.PORT || 3000;
httpServer.listen(PORT, () => {
  console.log(`🚀 ConnectUs Backend running fine - http://localhost:${PORT}/graphql`);
});