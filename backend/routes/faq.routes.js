const { create, getAll } = require("../controllers/faq.controller");
const router = require("express").Router();

router.post("/", create);
router.get("/", getAll);

module.exports = router;
