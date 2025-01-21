const {
  getAmharicResponse,
  getEnglishResponse,
} = require("../controllers/chat.controller");
const router = require("express").Router();

// chat route
router.post("/amharic", getAmharicResponse);
router.post("/english", getEnglishResponse);

module.exports = router;
