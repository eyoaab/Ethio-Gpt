const { Hercai } = require("hercai");
const { translate } = require("bing-translate-api");
const ChatRoom = require("../models/chat.model");
const Message = require("../models/message.model");

const herc = new Hercai();

// Function to create and save a message in the database
async function saveMessage(roomId, prompt, replyInAmharic) {
  const message = new Message({
    isBot: false,
    content: prompt,
    roomId: roomId,
  });

  const botMessage = new Message({
    isBot: true,
    content: replyInAmharic,
    roomId: roomId,
  });

  await message.save();
  await botMessage.save();
}

exports.getAmharicResponse = async (req, res) => {
  try {
    const { prompt, roomId } = req.body;
    const userId = req.userId;

    if (!prompt || typeof prompt !== "string") {
      return res.status(400).json({ message: "ትክክለኛ ጥያቄ ያስፈልጋል" });
    }

    if (roomId && !mongoose.Types.ObjectId.isValid(roomId)) {
      return res.status(400).json({ message: "Invalid room ID." });
    }

    try {
      const { translation: englishPrompt } = await translate(
        prompt,
        "am",
        "en"
      );

      const aiResponse = await herc.question({
        model: "v3",
        content: englishPrompt,
      });

      if (!aiResponse || !aiResponse.reply) {
        throw new Error("ትክክለኛ ምላሽ ከ AI ማግኘት አልተሳካም እባክዎ እንደገና ይሞክሩ.");
      }

      const aiReplyInEnglish = aiResponse.reply;

      const { translation: replyInAmharic } = await translate(
        aiReplyInEnglish,
        "en",
        "am"
      );

      let room;

      if (!roomId) {
        room = new ChatRoom({ messages: [], userId: userId });
        room = await room.save();
      } else {
        room = await ChatRoom.findById(roomId);

        if (!room) {
          return res.status(404).json({ message: "Chat room not found." });
        }
      }
      // save message
      await saveMessage(room._id, prompt, replyInAmharic);

      res.status(200).json({ response: replyInAmharic });
    } catch (error) {
      console.error("Error:", error);
      res.status(500).json({
        message: error.message || "ጥያቄዎን በማስኬድ ላይ ስህተት አጋጥሟል።",
      });
    }
  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({
      message: error.message || "ጥያቄዎን በማስኬድ ላይ ስህተት አጋጥሟል።",
    });
  }
};

// to english prompts
exports.getEnglishResponse = async (req, res) => {
  try {
    const { prompt, roomId } = req.body;
    const userId = req.userId;

    if (!prompt || typeof prompt !== "string") {
      return res.status(400).json({ error: "Valid prompt is required." });
    }
    if (roomId && !mongoose.Types.ObjectId.isValid(roomId)) {
      return res.status(400).json({ message: "Invalid room ID." });
    }

    try {
      const aiResponse = await herc.question({
        model: "v3",
        content: prompt,
      });

      if (!aiResponse || !aiResponse.reply) {
        throw new Error("Failed to get a valid response from AI.");
      }
      const aiReplyInEnglish = aiResponse.reply;

      let room;

      if (!roomId) {
        room = new ChatRoom({ messages: [], userId: userId });
        room = await room.save();
      } else {
        room = await ChatRoom.findById(roomId);

        if (!room) {
          return res.status(404).json({ message: "Chat room not found." });
        }
      }

      // save message
      await saveMessage(room._id, prompt, aiReplyInEnglish);

      // Respond with the translated reply
      res.status(200).json({ response: aiReplyInEnglish });
    } catch (error) {
      console.error("Error processing /gpt request:", error);
      res.status(500).json({
        error:
          error.message || "An error occurred while processing your request.",
      });
    }
  } catch (error) {
    console.error("Error processing /gpt request:", error);
    res.status(500).json({
      error:
        error.message || "An error occurred while processing your request.",
    });
  }
};
