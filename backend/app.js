const express = require("express");
const cors = require("cors");
const dotenv = require("dotenv");

const connectDB = require("./configuration/db.config");

// Routes
const userRoutes = require("./routes/user.routes");
const chatRoutes = require("./routes/chat.routes");
const feedbackRoutes = require("./routes/feedback.routes");

dotenv.config();
connectDB();

const app = express();
app.use(express.json());
app.use(cors());

app.use("/user", userRoutes);
app.use("/chat", chatRoutes);
app.use("/feedback", feedbackRoutes);

// Global error handler
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(err.status || 500).json({
    message: err.message || "Internal Server Error",
    stack: process.env.NODE_ENV === "production" ? null : err.stack,
  });
});

module.exports = app;
