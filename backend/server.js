import express from 'express';
import { createYoga, createSchema, createPubSub } from 'graphql-yoga';
import { createServer } from 'http';
import { WebSocketServer } from 'ws';
import { useServer } from 'graphql-ws/use/ws';

const pubsub = createPubSub();
const messagesByRoom = new Map();

const typeDefs = `
  type Message {
    id: ID!
    user: String!
    text: String!
    roomId: String!
    createdAt: String
  }

  type Query {
    messages(roomId: String!): [Message!]!
  }

  type Mutation {
    postMessage(roomId: String!, user: String!, text: String!): ID!
  }

  type Subscription {
    messages(roomId: String!): [Message!]!
  }
`;

const resolvers = {
  Query: {
    messages: (_, { roomId }) => messagesByRoom.get(roomId) || [],
  },
  Mutation: {
    postMessage: (_, { roomId, user, text }) => {
      if (!text || text.length === 0 || text.length > 2000) {
        throw new Error('Invalid message');
      }
      if (!messagesByRoom.has(roomId)) messagesByRoom.set(roomId, []);
      const roomMessages = messagesByRoom.get(roomId);
      const id = roomMessages.length;
      const msg = {
        id,
        user,
        text,
        roomId,
        createdAt: new Date().toISOString(),
      };
      roomMessages.push(msg);
      pubsub.publish(`MSG_UPDATE:${roomId}`, { messages: roomMessages });
      return id;
    },
  },
  Subscription: {
    messages: {
      subscribe: (_, { roomId }) => pubsub.subscribe(`MSG_UPDATE:${roomId}`),
    },
  },
};

const schema = createSchema({ typeDefs, resolvers });
const app = express();
const httpServer = createServer(app);

const yoga = createYoga({
  schema,
  graphqlEndpoint: '/graphql',
  graphiql: process.env.NODE_ENV !== 'production' ? { subscriptionsProtocol: 'WS' } : false,
});

const wsServer = new WebSocketServer({
  server: httpServer,
  path: yoga.graphqlEndpoint,
});

useServer({ schema }, wsServer);
app.use(yoga.graphqlEndpoint, yoga);

const PORT = process.env.PORT || 3000;
httpServer.listen(PORT, () => {
  console.log(`🚀 Server running at http://localhost:${PORT}/graphql`);
});