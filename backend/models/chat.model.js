const mongoose = require("mongoose");
const { v4: uuidv4 } = require("uuid");

// ChatRoom Schema
const chatRoomSchema = new mongoose.Schema({
  roomId: {
    type: String,
    unique: true,
    default: uuidv4, // Generates a UUID if no roomId is provided
    trim: true,
  },

  messages: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Message",
    },
  ],
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true,
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
  updatedAt: {
    type: Date,
    default: Date.now,
  },
});

module.exports = mongoose.model("ChatRoom", chatRoomSchema);
