const {
  createUser,
  loginUser,
  updateUserEmail,
  updateUserPassword,
  deleteUser,
} = require("../controllers/user.controller");
const router = require("express").Router();

router.post("/register", createUser);
router.post("/login", loginUser);
router.put("/updateEmail", updateUserEmail);
router.put("/updatePassword", updateUserPassword);
router.delete("/delete", deleteUser);

module.exports = router;
