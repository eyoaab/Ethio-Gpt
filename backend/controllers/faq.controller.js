const Faq = require("../models/faq.model");

// Create and Save a new FAQ
exports.create = async (req, res) => {
  try {
    const { question, answer } = req.body;

    if (!question || !answer) {
      return res.status(400).json({
        message: "Question and answer are required.",
      });
    }

    const faq = new Faq({ question, answer });
    const savedFaq = await faq.save();

    res.status(201).json({
      message: "FAQ created successfully.",
      data: savedFaq,
    });
  } catch (error) {
    res.status(500).json({
      message: "An error occurred while creating the FAQ.",
      error: error.message,
    });
  }
};

// Get all FAQs
exports.getAll = async (req, res) => {
  try {
    const faqs = await Faq.find();

    res.status(200).json({
      faqs: faqs,
    });
  } catch (error) {
    res.status(500).json({
      message: "An error occurred while retrieving the FAQs.",
      error: error.message,
    });
  }
};
