const { createUser, loginUser } = require("../controllers/user.controller");
const router = require("express").Router();

// create user route

router.post("/register", createUser);
router.post("/login", loginUser);

module.exports = router;
