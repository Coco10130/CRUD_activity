const express = require("express");
const {
  read,
  create,
  update,
  remove,
  getStudent,
} = require("../controllers/student.controller");
const router = express.Router();

router.get("/get", read);

router.get("/get/:id", getStudent);

router.post("/add", create);

router.put("/edit/:id", update);

router.delete("/delete/:id", remove);

module.exports = router;
