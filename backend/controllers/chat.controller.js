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

    // Validate input
    if (!prompt || typeof prompt !== "string") {
      return res.status(400).json({ message: "ትክክለኛ ጥያቄ ያስፈልጋል" });
    }

    // Validate roomId (if provided)
    if (roomId && !mongoose.Types.ObjectId.isValid(roomId)) {
      return res.status(400).json({ message: "Invalid room ID." });
    }

    try {
      // Step 1: Translate the prompt from Amharic to English
      const { translation: englishPrompt } = await translate(
        prompt,
        "am",
        "en"
      );

      // Step 2: Get AI response in English
      const aiResponse = await herc.question({
        model: "v3",
        content: englishPrompt,
      });

      if (!aiResponse || !aiResponse.reply) {
        throw new Error("ትክክለኛ ምላሽ ከ AI ማግኘት አልተሳካም እባክዎ እንደገና ይሞክሩ.");
      }

      const aiReplyInEnglish = aiResponse.reply;

      // Step 3: Translate the AI response from English back to Amharic
      const { translation: replyInAmharic } = await translate(
        aiReplyInEnglish,
        "en",
        "am"
      );

      // Step 4: Handle Chat Room logic
      let room;

      if (!roomId) {
        // Create a new room if roomId is not provided
        room = new ChatRoom({ messages: [] });
        room = await room.save();
      } else {
        // Use the provided roomId
        room = await ChatRoom.findById(roomId);

        if (!room) {
          return res.status(404).json({ error: "Chat room not found." });
        }
      }

      // Save the messages in the room
      await saveMessage(room._id, prompt, replyInAmharic);

      // Respond with the translated reply
      res.status(200).json({ response: replyInAmharic });
    } catch (error) {
      console.error("Error:", error);
      res.status(500).json({
        error: error.message || "ጥያቄዎን በማስኬድ ላይ ስህተት አጋጥሟል።",
      });
    }
  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({
      error: error.message || "ጥያቄዎን በማስኬድ ላይ ስህተት አጋጥሟል።",
    });
  }
};

// to english prompts
exports.getEnglishResponse = async (req, res) => {
  try {
    const { prompt } = req.body;

    // Validate the input
    if (!prompt || typeof prompt !== "string") {
      return res.status(400).json({ error: "Valid prompt is required." });
    }

    try {
      // Step 2: Get AI response in English
      const aiResponse = await herc.question({
        model: "v3",
        content: prompt,
      });

      if (!aiResponse || !aiResponse.reply) {
        throw new Error("Failed to get a valid response from AI.");
      }
      const aiReplyInEnglish = aiResponse.reply;

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
