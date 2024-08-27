const mongoose = require("mongoose");

const StudentSchema = mongoose.Schema(
  {
    firstName: {
      type: String,
      required: true,
    },

    lastName: {
      type: String,
      required: true,
    },

    course: {
      type: String,
      required: true,
    },

    year: {
      type: String,
      required: true,
    },

    enrolled: {
      type: Boolean,
      default: false,
    },
  },
  {
    timestamps: true,
  }
);

const Student = mongoose.model("student", StudentSchema);

module.exports = Student;
