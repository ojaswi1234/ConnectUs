import express from 'express';
import { createServer } from 'http';
import { WebSocketServer } from 'ws';
import { SubscriptionServer } from 'subscriptions-transport-ws';
import { execute, subscribe } from 'graphql';
import { createSchema } from 'graphql-yoga';
import { createPubSub } from 'graphql-yoga';

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

// HTTP GraphQL endpoint (for mutations & queries)
app.post('/graphql', express.json(), async (req, res) => {
  const { query, variables, operationName } = req.body;
  const result = await execute({
    schema,
    document: query,
    variableValues: variables,
    operationName,
  });
  res.json(result);
});

app.get('/graphql', (req, res) => {
  res.status(405).send('Use POST for GraphQL queries');
});

// Legacy WebSocket for Flutter gql_websocket_link
const wsServer = new WebSocketServer({
  server: httpServer,
  path: '/graphql',
});

SubscriptionServer.create(
  {
    schema,
    execute,
    subscribe,
    onConnect: (connectionParams) => {
      // Optional: validate JWT from connectionParams.authorization
      return {};
    },
  },
  {
    server: wsServer,
    path: '/graphql',
  }
);

const PORT = process.env.PORT || 3000;
httpServer.listen(PORT, () => {
  console.log(`🚀 Server running at http://localhost:${PORT}/graphql`);
  console.log(`📡 WebSocket (legacy) ready at ws://localhost:${PORT}/graphql`);
});