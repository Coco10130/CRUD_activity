const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
require("dotenv").config();
const studentRouter = require("./routes/student.route");

// middleware
const app = express();
app.use(express.json());
app.use(cors());

// default route
app.get("/", (res, req) => {
  res.setEncoding("Hello World");
});

// route
app.use("/api/student/", studentRouter);

// connect to mongodb
const port = process.env.PORT || 3000;
mongoose.connect(process.env.MONGODB).then(() => {
  console.log("Connected to MongoDB");
  app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
  });
});
