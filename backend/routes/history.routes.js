const {
  getRecentRooms,
  getOlderChatRooms,
  getMessagesInRoom,
  delteChatRoom,
} = require("../controllers/history.controller");
const authenticateToken = require("../middlewares/auth.middleware");
const router = require("express").Router();

router.get("/recent", authenticateToken, getRecentRooms);
router.get("/oldRooms", authenticateToken, getOlderChatRooms);
router.get("/messages/:roomId", getMessagesInRoom);
router.delete("/", delteChatRoom);

module.exports = router;
