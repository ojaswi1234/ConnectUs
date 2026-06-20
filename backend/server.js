/**
 * ConnectUs Backend — Phase 2.2
 *
 * Improvements over the original:
 *  1. Messages are persisted in Supabase Postgres (chat_messages table).
 *  2. GraphQL schema includes roomId, createdAt, and proper typing.
 *  3. Subscription now delivers a single Message event (not the whole list).
 *  4. Room-scoped delivery: clients only receive messages for the room they
 *     are subscribed to via the `ROOM_${roomId}` pubsub topic.
 *  5. Supabase credentials loaded from environment variables (.env via dotenv).
 *  6. postMessage mutation returns the full Message object (not just an ID).
 */

import 'dotenv/config';
import express from 'express';
import { createYoga, createSchema, createPubSub } from 'graphql-yoga';
import { createServer } from 'http';
import { WebSocketServer } from 'ws';
import { useServer } from 'graphql-ws/use/ws';
import { createClient } from '@supabase/supabase-js';

// ---------------------------------------------------------------------------
// 1. SUPABASE CLIENT (server-side, uses SUPABASE_SERVICE_KEY if available,
//    falls back to anon key which is fine for a trusted Node environment)
// ---------------------------------------------------------------------------
const SUPABASE_URL = process.env.SUPABASE_URL || '';
const SUPABASE_KEY =
  process.env.SUPABASE_SERVICE_KEY ||
  process.env.SUPABASE_ANON_KEY ||
  '';

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

// ---------------------------------------------------------------------------
// 2. PUB/SUB (in-process; works fine for a single-instance deployment)
// ---------------------------------------------------------------------------
const pubsub = createPubSub();

// ---------------------------------------------------------------------------
// 3. SCHEMA (updated to match Phase 2 plan)
// ---------------------------------------------------------------------------
const typeDefs = /* GraphQL */ `
  type Message {
    id: ID!
    roomId: String!
    user: String!
    text: String!
    createdAt: String!
  }

  type Query {
    messages(roomId: String!): [Message!]
  }

  type Mutation {
    postMessage(roomId: String!, user: String!, text: String!): Message!
  }

  type Subscription {
    messages(roomId: String!): Message!
  }
`;

// ---------------------------------------------------------------------------
// 4. RESOLVERS
// ---------------------------------------------------------------------------
const resolvers = {
  Query: {
    /**
     * Fetches the last 100 messages for a room from Postgres.
     * Results are ordered by created_at ASC so the client sees oldest first.
     */
    messages: async (_, { roomId }) => {
      const { data, error } = await supabase
        .from('chat_messages')
        .select('id, room_id, sender_username, content, created_at')
        .eq('room_id', roomId)
        .order('created_at', { ascending: true })
        .limit(100);

      if (error) {
        console.error('Error fetching messages:', error);
        return [];
      }

      return (data || []).map(row => ({
        id: String(row.id),
        roomId: row.room_id,
        user: row.sender_username,
        text: row.content,
        createdAt: row.created_at,
      }));
    },
  },

  Mutation: {
    /**
     * Inserts a message into Postgres and broadcasts it to subscribers of
     * the room. Returns the persisted message.
     */
    postMessage: async (_, { roomId, user, text }) => {
      const { data, error } = await supabase
        .from('chat_messages')
        .insert({ room_id: roomId, sender_username: user, content: text })
        .select()
        .single();

      if (error) {
        console.error('Error inserting message:', error);
        throw new Error('Failed to send message');
      }

      const message = {
        id: String(data.id),
        roomId: data.room_id,
        user: data.sender_username,
        text: data.content,
        createdAt: data.created_at,
      };

      // Publish to room-scoped topic so only subscribers of this room get it
      pubsub.publish(`ROOM_${roomId}`, { messages: message });

      return message;
    },
  },

  Subscription: {
    messages: {
      /**
       * Clients subscribe by passing their roomId.
       * Only messages for that specific room are delivered.
       */
      subscribe: async function* (_, { roomId }) {
        const sub = pubsub.subscribe(`ROOM_${roomId}`);
        for await (const event of sub) {
          yield event;
        }
      },
      resolve: payload => payload.messages,
    },
  },
};

// ---------------------------------------------------------------------------
// 5. SERVER SETUP
// ---------------------------------------------------------------------------
const schema = createSchema({ typeDefs, resolvers });
const app = express();
const httpServer = createServer(app);

const yoga = createYoga({
  schema,
  graphqlEndpoint: '/graphql',
  graphiql: { subscriptionsProtocol: 'WS' },
  cors: {
    origin: '*',
    credentials: true,
  },
});

const wsServer = new WebSocketServer({
  server: httpServer,
  path: yoga.graphqlEndpoint,
});

useServer({ schema }, wsServer);

// ---------------------------------------------------------------------------
// 6. ROUTING & START
// ---------------------------------------------------------------------------
app.use(yoga.graphqlEndpoint, yoga);

// Health check endpoint
app.get('/health', (_, res) => res.json({ status: 'ok' }));

const PORT = process.env.PORT || 3000;
httpServer.listen(PORT, () => {
  console.log(`🚀 ConnectUs Backend running — http://localhost:${PORT}/graphql`);
  if (!SUPABASE_URL || !SUPABASE_KEY) {
    console.warn(
      '⚠️  SUPABASE_URL / SUPABASE_ANON_KEY not set. Messages will fail to persist. ' +
      'Create a .env file in the /backend directory.'
    );
  }
});