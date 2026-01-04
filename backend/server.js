import { createServer } from "http";
import { createSchema, createYoga, createPubSub } from "graphql-yoga"; // Added createPubSub
import dotenv from "dotenv";
dotenv.config();

const PORT = process.env.PORT || 3000;
const messages = [];
const pubSub = createPubSub(); // Initialize PubSub instance

createServer(
  createYoga({
    schema: createSchema({
      typeDefs: /* GraphQL */ `
        type Message {
          id: ID!
          user: String!
          content: String!
        }
        type Query {
          messages: [Message!]
        }
        type Mutation {
          postMessage(user: String!, content: String!): ID!
        }
        type Subscription {
          messageAdded: Message! # New Subscription type
        }
      `,
      resolvers: {
        Query: {
          messages: () => messages,
        },
        Mutation: {
          postMessage: (parent, { user, content }) => {
            const id = String(messages.length);
            const newMessage = { id, user, content };
            messages.push(newMessage);
            
            // Publish the message to the 'MESSAGE_ADDED' channel
            pubSub.publish("MESSAGE_ADDED", { messageAdded: newMessage });
            
            return id;
          },
        },
        Subscription: {
          messageAdded: {
            // Subscribe to the channel
            subscribe: () => pubSub.subscribe("MESSAGE_ADDED"),
          },
        },
      },
    }),
  })
).listen(PORT, () => {
  console.info(`GraphQL Yoga is listening on http://localhost:${PORT}/graphql`);
});