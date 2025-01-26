const ChatRoom = require("../models/chatRoom.model");
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
        options: { sort: { timestamp: -1 }, limit: 1 }, // Get only the latest message
      })
      .sort({ updatedAt: -1 });

    // Query for rooms updated yesterday
    const roomsYesterday = await ChatRoom.find({
      userId: userId,
      updatedAt: { $gte: yesterdayStart, $lt: todayStart }, // Yesterday's range
    })
      .populate({
        path: "messages",
        options: { sort: { timestamp: -1 }, limit: 1 }, // Get only the latest message
      })
      .sort({ updatedAt: -1 });

    // Query for "Old" rooms with pagination (rooms that are older than yesterday)
    const roomsOld = await ChatRoom.find({
      userId: userId,
      updatedAt: { $lt: yesterdayStart },
    })
      .populate({
        path: "messages",
        options: { sort: { timestamp: -1 }, limit: 1 }, // Get only the latest message
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
    const page = parseInt(req.query.page) || 1;
    const limit = 5; // You can adjust this as needed

    // Fetch older chat rooms (rooms older than yesterday)
    const roomsOld = await ChatRoom.find({
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
