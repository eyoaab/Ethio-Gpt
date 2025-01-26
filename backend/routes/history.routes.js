const {
  getRecentRooms,
  getOlderChatRooms,
  getMessagesInRoom,
} = require("../controllers/history.controller");
const authenticateToken = require("../middlewares/auth.middleware");
const router = require("express").Router();

router.get("/recent", authenticateToken, getRecentRooms);
router.get("/oldRooms", authenticateToken, getOlderChatRooms);
router.get("/messages/:roomId", getMessagesInRoom);

module.exports = router;
