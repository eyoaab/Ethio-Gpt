const User = require("../models/user.model");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");

// Function to create a new user
exports.createUser = async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({
        message: "Email and password are required.",
      });
    }

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({
        message: "A user with this email already exists.",
      });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const user = new User({ email, password: hashedPassword });

    await user.save();

    const token = jwt.sign(
      { id: user._id, email: user.email },
      process.env.JWT_SECRET
    );

    res.status(201).json({
      message: "User registered successfully!",
      token,
    });
  } catch (error) {
    console.error("Error creating user:", error.message);
    res.status(500).json({
      message: "An error occurred while creating the user.",
      error: error.message,
    });
  }
};

// Function to login a user
exports.loginUser = async (req, res) => {
  try {
    const { email, password } = req.body;

    // Validate input
    if (!email || !password) {
      return res.status(400).json({
        message: "Email and password are required.",
      });
    }

    // Find the user by email
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(400).json({
        message: "User with this email does not exist.",
      });
    }

    // Validate the password
    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
      return res.status(400).json({
        message: "Invalid password.",
      });
    }

    // Generate a JWT token
    const token = jwt.sign(
      { id: user._id, email: user.email },
      process.env.JWT_SECRET
    );

    res.status(200).json({
      message: "User logged in successfully.",
      token,
    });
  } catch (error) {
    console.error("Error logging in user:", error);
    res.status(500).json({
      message: "An error occurred while logging in the user.",
      error: error.message,
    });
  }
};

// Function to update user email
exports.updateUserEmail = async (req, res) => {
  try {
    const oldEmail = req.email;
    const newEmail = req.body.email;
    const password = req.body.password;
    const user = await User.findOne({ email: oldEmail });
    if (!user) {
      return res.status(400).json({
        message: "User with this email does not exist.",
      });
    }

    const user2 = await User.findOne({ email: newEmail });
    if (user2) {
      return res.status(400).json({
        message: "User with this email already exist",
      });
    }
    //  compare ther password here
    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
      return res.status(401).json({
        message: "Password is not correct please try again",
      });
    }
    user.email = newEmail;
    await user.save();
    const token = jwt.sign(
      { id: user._id, email: user.email },
      process.env.JWT_SECRET
    );

    res.status(200).json({
      message: "Email updated successfully.",
      token: token,
    });
  } catch (error) {
    console.error("Error updating user email:", error);
    res.status(500).json({
      message: "An error occurred while updating the email.",
      error: error.message,
    });
  }
};

// Function to update user password
exports.updateUserPassword = async (req, res) => {
  try {
    const email = req.email;
    const { oldPassword, newPassword } = req.body;

    // Validate input
    if (!oldPassword || !newPassword) {
      return res.status(400).json({
        message: "Email, old password, and new password are required.",
      });
    }

    // Find the user by email
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).json({
        message: "User with this email does not exist.",
      });
    }

    // Verify the old password
    const isPasswordValid = await bcrypt.compare(oldPassword, user.password);
    if (!isPasswordValid) {
      return res.status(401).json({
        message: "Invalid old password.",
      });
    }

    // Hash the new password
    const hashedPassword = await bcrypt.hash(newPassword, 10);

    // Update the user's password
    user.password = hashedPassword;
    await user.save();
    const token = jwt.sign(
      { id: user._id, email: user.email },
      process.env.JWT_SECRET
    );

    res.status(200).json({
      message: "Password updated successfully.",
      token: token,
    });
  } catch (error) {
    console.error("Error updating user password:", error.message);
    res.status(500).json({
      message: "An error occurred while updating the password.",
      error: error.message,
    });
  }
};

// Function to delete a user
exports.deleteUser = async (req, res) => {
  try {
    const email = req.email;
    const { password } = req.body;

    if (!email || !password) {
      return res.status(400).json({
        message: "Email and password are required.",
      });
    }

    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).json({
        message: "User with this email does not exist.",
      });
    }

    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
      return res.status(401).json({
        message: "Invalid password. Please try again.",
      });
    }

    await User.deleteOne({ email });

    res.status(200).json({
      message: "User deleted successfully.",
    });
  } catch (error) {
    console.error("Error deleting user:", error.message);
    res.status(500).json({
      message: "An error occurred while deleting the user.",
      error: error.message,
    });
  }
};
