const { GoogleGenerativeAI } = require("@google/generative-ai");
const { translate } = require("bing-translate-api");
const ChatRoom = require("../models/chat.model");
const Message = require("../models/message.model");

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);

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

      const model = genAI.getGenerativeModel({ model: "gemini-pro" });
      const result = await model.generateContent(englishPrompt);
      const response = result.response.text();
      ///

      const { translation: replyInAmharic } = await translate(
        response,
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
      return res.status(400).json({ message: "proper prompt is required" });
    }

    try {
      const model = genAI.getGenerativeModel({ model: "gemini-pro" });
      const result = await model.generateContent(prompt);
      const response = result.response.text();
      ///

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
      await saveMessage(chat._id, prompt, response);

      res.status(200).json({ response: response, roomId: chat._id });
    } catch (error) {
      console.error("Error:", error);
      res.status(500).json({
        message: error.message || "Ther is a problem in your please try again.",
      });
    }
  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({
      message: error.message || "Ther is a problem in your please try again.",
    });
  }
};

// function to delete a chat room
exports.deleteChatRoom = async (req, res) => {
  try {
    const { roomId } = req.body;
    if (!roomId) {
      return res.status(400).json({ message: "Room ID is required." });
    }
    const room = await ChatRoom.findById(roomId);
    // if room is not found

    if (!room) {
      return res.status(404).json({ message: "Chat room not found." });
    }
    // delete room
    await room.deleteOne();
    res.status(200).json({ message: "Chat room deleted successfully." });
  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({
      message:
        error.message || "An error occurred while processing your request.",
    });
  }
};
