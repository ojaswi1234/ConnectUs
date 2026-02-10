import express from 'express';
import { createYoga, createSchema } from 'graphql-yoga';
import { createServer } from 'http';
import { WebSocketServer } from 'ws';
import { useServer } from 'graphql-ws/use/ws';
import { createPubSub } from 'graphql-yoga';

// 1. STATE & REAL-TIME
const pubsub = createPubSub(); 
const messages = [];

// 2. SCHEMA
const typeDefs = `
  type Message {
    id: ID!
    user: String!
    text: String!
  }
  type Query {
    messages: [Message!]
  }
  type Mutation {
    postMessage(user: String!, text: String!): ID!
  }
  type Subscription {
    messages: [Message!]
  }
`;

// 3. RESOLVERS
const resolvers = {
  Query: {
    messages: () => messages,
  },
  Mutation: {
    postMessage: (_, { user, text }) => {
      const id = messages.length;
      messages.push({ id, user, text });
      pubsub.publish('MSG_UPDATE', { messages: messages });
      return id;
    },
  },
  Subscription: {
    messages: {
      subscribe: () => pubsub.subscribe('MSG_UPDATE'),
    },
  },
};

const schema = createSchema({ typeDefs, resolvers });

// 4. SERVER SETUP
const app = express(); // Keep Express for future middleware (Auth, Logging)
const httpServer = createServer(app);

const yoga = createYoga({
  schema,
  graphqlEndpoint: '/graphql',
  graphiql: { subscriptionsProtocol: 'WS' }
});

const wsServer = new WebSocketServer({
  server: httpServer,
  path: yoga.graphqlEndpoint,
});

useServer({ schema }, wsServer);

// 5. ROUTING
app.use(yoga.graphqlEndpoint, yoga);

// 6. START

let PORT= process.env.PORT || 3000;
httpServer.listen(PORT, () => {
  console.log('🚀 ConnectUs Backend running fine - http://localhost:3000/graphql');
});