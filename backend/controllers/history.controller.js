const ChatRoom = require("../models/chat.model");
const Message = require("../models/message.model");

// Helper function to get the date range for today, yesterday, and old
const getDateRange = (timeFrame) => {
  const now = new Date();
  let startDate;

  switch (timeFrame) {
    case "today":
      startDate = new Date(now.setHours(0, 0, 0, 0)); // Set to start of today
      break;
    case "yesterday":
      now.setDate(now.getDate() - 1); // Set to yesterday
      startDate = new Date(now.setHours(0, 0, 0, 0));
      break;
    default:
      startDate = null; // For "Old" rooms, no specific start date
  }

  return startDate;
};

// Controller function to fetch rooms categorized as Today, Yesterday, and Old
exports.getRecentRooms = async (req, res) => {
  try {
    const userId = req.userId;

    // Get the date ranges for today and yesterday
    const todayStart = getDateRange("today");
    const yesterdayStart = getDateRange("yesterday");

    // Get pagination options for "Old" rooms (default to page 1 with 5 rooms per page)
    const page = parseInt(req.query.page) || 1;
    const limit = 5;

    // Query for rooms updated today
    const roomsToday = await ChatRoom.find({
      userId: userId,
      updatedAt: { $gte: todayStart },
    })
      .populate({
        path: "messages",
        options: { sort: { timestamp: -1 } }, // Get only the latest message
        select: "-timestamp -__v -_id", // Get only the latest message
      })
      .sort({ updatedAt: -1 })
      .select("-createdAt -updatedAt -__v");

    // Query for rooms updated yesterday
    const roomsYesterday = await ChatRoom.find({
      userId: userId,
      updatedAt: { $gte: yesterdayStart, $lt: todayStart }, // Yesterday's range
    })
      .populate({
        path: "messages",
        options: { sort: { timestamp: -1 } },
        select: "-timestamp -__v -_id", // Get only the latest message
      })
      .sort({ updatedAt: -1 })
      .select("-createdAt -updatedAt -__v");

    // Query for "Old" rooms with pagination (rooms that are older than yesterday)
    const roomsOld = await ChatRoom.find({
      userId: userId,
      updatedAt: { $lt: yesterdayStart },
    })
      .populate({
        path: "messages",
        options: { sort: { timestamp: -1 } }, // Get only the latest message
      })
      .sort({ updatedAt: -1 })
      .skip((page - 1) * limit) // Pagination: skip previous pages
      .limit(limit); // Limit to 5 rooms per page

    res.status(200).json({
      roomsToday,
      roomsYesterday,
      roomsOld,
    });
  } catch (error) {
    console.error("Error fetching chat rooms:", error);
    res.status(500).json({
      message: "An error occurred while fetching chat rooms.",
      error: error.message,
    });
  }
};

// Controller function to fetch older chat rooms with pagination
exports.getOlderChatRooms = async (req, res) => {
  try {
    // Pagination parameters: page and limit
    const userId = req.userId;
    const page = parseInt(req.query.page) || 1;
    const limit = 5; // You can adjust this as needed

    // Fetch older chat rooms (rooms older than yesterday)
    const roomsOld = await ChatRoom.find({
      userId: userId,
      updatedAt: {
        $lt: new Date(new Date().setDate(new Date().getDate() - 1)),
      }, // Rooms older than yesterday
    })
      .populate({
        path: "messages",
        options: { sort: { timestamp: -1 }, limit: 1 }, // Only get the latest message in the room
      })
      .sort({ updatedAt: -1 }) // Sort by last updated
      .skip((page - 1) * limit) // Skip rooms based on the page number
      .limit(limit); // Limit to 5 rooms per page

    res.status(200).json({
      page,
      limit,
      totalRooms: roomsOld.length,
      rooms: roomsOld,
    });
  } catch (error) {
    console.error("Error fetching older chat rooms:", error);
    res.status(500).json({
      message: "An error occurred while fetching older chat rooms.",
      error: error.message,
    });
  }
};

// Function to fetch messages in a specific chat room with pagination
exports.getMessagesInRoom = async (req, res) => {
  try {
    const { roomId } = req.params;
    const { page = 1, pageSize = 5 } = req.query; // Default to page 1 and 5 messages per page

    // Validate the page and pageSize to ensure they are numbers
    const pageNumber = parseInt(page, 10);
    const pageSizeNumber = parseInt(pageSize, 10);

    if (
      isNaN(pageNumber) ||
      isNaN(pageSizeNumber) ||
      pageNumber <= 0 ||
      pageSizeNumber <= 0
    ) {
      return res.status(400).json({
        message: "Invalid page or pageSize. Please provide valid numbers.",
      });
    }

    // Find the chat room by roomId
    const chatRoom = await ChatRoom.findOne({ roomId }).populate({
      path: "messages",
      options: {
        skip: (pageNumber - 1) * pageSizeNumber, // Skip messages based on page
        limit: pageSizeNumber, // Limit the number of messages
        sort: { timestamp: -1 }, // Sort by timestamp in descending order (latest first)
      },
      select: "content timestamp isBot", // Select relevant fields for messages
    });

    if (!chatRoom) {
      return res.status(404).json({
        message: "Chat room not found.",
      });
    }

    // Return the paginated messages
    res.status(200).json({
      messages: chatRoom.messages,
      page: pageNumber,
      pageSize: pageSizeNumber,
      totalMessages: chatRoom.messages.length, // Total number of messages
      totalPages: Math.ceil(chatRoom.messages.length / pageSizeNumber), // Total pages based on pagination
    });
  } catch (error) {
    console.error("Error fetching messages for chat room:", error);
    res.status(500).json({
      message: "An error occurred while fetching the messages.",
      error: error.message,
    });
  }
};

// Controller to delete a chat hisstory
exports.delteChatRoom = async (req, res) => {
  try {
    const cahtRoomId = req.body;
    await ChatRoom.findByIdAndDelete({ cahtRoomId });
    res.status(200).json({
      message: "Chat Historoy Deleted Successfully",
    });
  } catch (error) {
    console.log("error occured while deleting the chat room", error);
    res.status(500).json({
      message: "error occured while deleting the chat room",
    });
  }
};
