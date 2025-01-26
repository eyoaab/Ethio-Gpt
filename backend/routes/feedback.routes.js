const {
  createFeedback,
  getAllFeedbacks,
} = require("../controllers/feedback.controller");
const authenticateToken = require("../middlewares/auth.middleware");
const router = require("express").Router();

// Create a new Feedback
router.post("/", authenticateToken, createFeedback);
router.get("/", getAllFeedbacks);

module.exports = router;
