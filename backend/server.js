const express = require('express');
const http = require('http');
const { Server } = require("socket.io");
const cors = require('cors');

const app = express();
app.use(cors()); // Enable CORS for all routes

const server = http.createServer(app);
const io = new Server(server, {
  cors: {
    origin: "*", // Allow all origins
    methods: ["GET", "POST"]
  }
});

const clients = new Map(); // Map to store userId -> socketId

io.on('connection', (socket) => {
  console.log('A user connected:', socket.id);

  // 1. Register a user and associate them with their socket ID
  socket.on('register', (userId) => {
    if (userId) {
      clients.set(userId, socket.id);
      console.log(`User ${userId} registered with socket ID ${socket.id}`);
      socket.emit('status', `User ${userId} registered.`);
    }
  });

  // 2. Handle private messages
  socket.on('privateMessage', ({ to, from, content }) => {
    const recipientSocketId = clients.get(to);
    if (recipientSocketId) {
      // Send to the recipient
      io.to(recipientSocketId).emit('message', {
        from,
        content,
        timestamp: new Date().toISOString()
      });
      console.log(`Message from ${from} to ${to}`);
    } else {
      console.log(`User ${to} not found or offline.`);
      // Optional: send a status back to the sender
      socket.emit('status', `User ${to} is not online.`);
    }
  });

  // 3. Handle disconnection
  socket.on('disconnect', () => {
    console.log('User disconnected:', socket.id);
    // Remove the user from the clients map
    for (let [userId, id] of clients.entries()) {
      if (id === socket.id) {
        clients.delete(userId);
        console.log(`User ${userId} unregistered.`);
        break;
      }
    }
  });
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

module.exports = { app, server, io }; // Export for testing or other modules
