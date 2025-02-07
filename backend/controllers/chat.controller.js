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
  });

  const botMessage = new Message({
    isBot: true,
    content: replyInAmharic,
  });

  await message.save();
  await botMessage.save();
  const chatRoom = await ChatRoom.findById(roomId);

  chatRoom.messages.push(message);
  chatRoom.messages.push(botMessage);
  await chatRoom.save();
}

exports.getAmharicResponse = async (req, res) => {
  try {
    const { prompt, roomId } = req.body;
    const userId = req.userId;

    if (!prompt || typeof prompt !== "string") {
      return res.status(400).json({ message: "ትክክለኛ ጥያቄ ያስፈልጋል" });
    }

    try {
      const { translation: englishPrompt } = await translate(
        prompt,
        "am",
        "en"
      );
      console.log("English prompt:", englishPrompt);

      const aiResponse = await herc.question({
        model: "v3",
        content: englishPrompt,
      });

      if (!aiResponse || !aiResponse.reply) {
        throw new Error("ትክክለኛ ምላሽ ከ AI ማግኘት አልተሳካም እባክዎ እንደገና ይሞክሩ.");
      }

      const aiReplyInEnglish = aiResponse.reply;
      console.log("AI reply:", aiResponse);
      console.log("AI reply in English:", aiReplyInEnglish);

      const { translation: replyInAmharic } = await translate(
        aiReplyInEnglish,
        "en",
        "am"
      );

      let chat;

      if (!roomId) {
        console.log("Creating new room since the room is none");

        chat = new ChatRoom({ messages: [], userId: userId });
        chat = await chat.save();
      } else {
        console.log("Finding room with id:", roomId);
        chat = await ChatRoom.findById(roomId);

        if (!chat) {
          return res.status(404).json({ message: "Chat room not found." });
        }
      }
      // save messag
      await saveMessage(chat._id, prompt, replyInAmharic);

      res.status(200).json({ response: replyInAmharic, roomId: chat._id });
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
    // if (roomId && !mongoose.Types.ObjectId.isValid(roomId)) {
    //   return res.status(400).json({ message: "Invalid room ID." });
    // }

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
      res.status(200).json({ response: aiReplyInEnglish, roomId: room._id });
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
