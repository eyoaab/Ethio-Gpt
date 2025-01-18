const mongoose = require("mongoose");

const messageSchema = new mongoose.Schema(
  {
    timestamp: { type: Date, default: Date.now },
    text: { type: String, default: "" },
    isUser: { type: Boolean, default: false },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Message", messageSchema);
