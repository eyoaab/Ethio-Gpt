const Feedback = require("../models/feedback.model");

// Create and Save a new Feedback
exports.createFeedback = async (req, res) => {
  try {
    const content = req.body.content;
    if (!content) {
      return res.status(400).send({
        message: "Fedback can not be empty",
      });
    }
    // Create a Feedback
    const feedback = new Feedback({
      content: content,
      userId: req.userId,
      email: req.email,
    });

    // Save Feedback in the database
    const data = await feedback.save();
    res.send(data);
  } catch (err) {
    res.status(500).send({
      message:
        err.message || "Some error occurred while creating the Feedback.",
    });
  }
};

// Retrieve all Feedbacks from the database.
exports.getAllFeedbacks = async (req, res) => {
  try {
    const data = await Feedback.find();
    res.status(200).json(data);
  } catch (err) {
    res.status(500).send({
      message: err.message || "Some error occurred while retrieving feedbacks.",
    });
  }
};
