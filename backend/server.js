
import { createServer } from "http";
import { WebSocketServer, WebSocket } from 'ws';
import { randomBytes, createCipheriv, createDecipheriv } from 'crypto';

// --- ENCRYPTION SETUP ---
const algorithm = 'aes-256-cbc';
const secretKey = randomBytes(32); 
const ivLength = 16;

function encrypt(text) {
  const iv = randomBytes(ivLength);
  const cipher = createCipheriv(algorithm, secretKey, iv);
  let encrypted = cipher.update(text);
  encrypted = Buffer.concat([encrypted, cipher.final()]);
  return iv.toString('hex') + ':' + encrypted.toString('hex');
}

function decrypt(text) {
  try {
    const textParts = text.split(':');
    const iv = Buffer.from(textParts.shift(), 'hex');
    const encryptedText = Buffer.from(textParts.join(':'), 'hex');
    const decipher = createDecipheriv(algorithm, secretKey, iv);
    let decrypted = decipher.update(encryptedText);
decrypted = Buffer.concat([decrypted, decipher.final()]);
    return decrypted.toString();
  } catch (error) {
    return "[Error: Could not decrypt message]";
  }
}
// ------------------------

const server = createServer();
const wss = new WebSocketServer({ server });

const clients = new Map(); // Map to store userId -> WebSocket connection
const messages = []; // To store chat history (optional)

wss.on('connection', (ws) => {
  ws.on('message', (rawMessage) => {
    try {
      const message = JSON.parse(rawMessage);

      // 1. Register a user and associate them with their WebSocket connection
      if (message.type === 'register' && message.userId) {
        clients.set(message.userId, ws);
        ws.userId = message.userId; // Attach userId to the ws object for easier cleanup
        ws.send(JSON.stringify({ type: 'status', message: `User ${message.userId} registered.` }));
        console.log(`User ${message.userId} connected.`);
        return;
      }

      // 2. Handle private messages
      if (message.type === 'privateMessage' && message.to && message.from && message.content) {
        const { to, from, content } = message;
        const recipientSocket = clients.get(to);

        const encryptedContent = encrypt(content);

        // Store the encrypted message
        const storedMessage = {
          id: String(messages.length),
          from,
          to,
          content: encryptedContent,
          createdAt: new Date().toISOString(),
        };
        messages.push(storedMessage);
        
        // 3. Send the encrypted message to the recipient if they are online
        if (recipientSocket && recipientSocket.readyState === WebSocket.OPEN) {
          recipientSocket.send(JSON.stringify({
            type: 'privateMessage',
            from,
            content: encryptedContent,
            createdAt: storedMessage.createdAt
          }));
        } else {
          // Optional: Handle offline users (e.g., store for later retrieval)
          console.log(`User ${to} is not online. Message stored.`);
        }
      }
    } catch (error) {
      console.error("Failed to process message:", error);
    }
  });

  ws.on('close', () => {
    if (ws.userId) {
      clients.delete(ws.userId);
      console.log(`User ${ws.userId} disconnected.`);
    }
  });

  ws.on('error', (error) => {
    console.error("WebSocket error:", error);
  });
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
  console.log(`WebSocket server is running on ws://localhost:${PORT}`);
});
