import { createServer } from "http"
import { createSchema, createYoga } from "graphql-yoga"
import dotenv from "dotenv";
dotenv.config();
const PORT = process.env.PORT || 4000;
const messages = [];
createServer(
  createYoga({
    schema: createSchema({
      typeDefs: /* GraphQL */ `
        type Message{
          id: ID!
          user: String!
          content: String!
        }
        type Query {
          messages: [Message!]
        }
        type Mutation {
          postMessage(user: String!, content: String!): ID!}
      `,
      resolvers: {
        Query: {
          messages: () => messages,
        },
        Mutation: {
          postMessage: (parent, {user, content}) => {
            const id = messages.length;
            messages.push({
              id,
              user,
              content,
            });
            return id;

          }
        }
      },
    }),
  }),
).listen(PORT, () => {
  console.info(`GraphQL Yoga is listening on http://localhost:${PORT}/graphql`)
})