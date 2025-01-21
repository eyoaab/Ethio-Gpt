const mongoose = require("mongoose");

const feedbackSchema = mongoose.Schema({
  content: { type: String, required: true },
  email: { type: String },
  userId: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
});

module.exports = mongoose.model("Feedback", feedbackSchema);
