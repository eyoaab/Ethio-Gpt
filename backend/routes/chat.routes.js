const {
  getAmharicResponse,
  getEnglishResponse,
  deleteChatRoom,
} = require("../controllers/chat.controller");
const authenticateToken = require("../middlewares/auth.middleware");

const router = require("express").Router();

// chat route
router.post("/amharic", authenticateToken, getAmharicResponse);
router.post("/english", authenticateToken, getEnglishResponse);
router.delete("/", authenticateToken, deleteChatRoom);

module.exports = router;
