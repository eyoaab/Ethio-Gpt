const {
  createUser,
  loginUser,
  updateUserEmail,
  updateUserPassword,
  deleteUser,
} = require("../controllers/user.controller");
const authenticateToken = require("../middlewares/auth.middleware");

const router = require("express").Router();

router.post("/register", createUser);
router.post("/login", loginUser);
router.put("/updateEmail", authenticateToken, updateUserEmail);
router.put("/updatePassword", authenticateToken, updateUserPassword);
router.delete("/delete", authenticateToken, deleteUser);

module.exports = router;
