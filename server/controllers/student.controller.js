const Student = require("../models/student.model");

const create = async (req, res) => {
  try {
    const newStudent = new Student(req.body);
    await newStudent.save();
    res.status(201).json({
      success: true,
      data: newStudent,
      message: "Student saved successfully!",
    });
  } catch (error) {
    res.status(400).json({ errorMessage: error.message });
  }
};

const update = async (req, res) => {
  try {
    const updatedStudent = await Student.findByIdAndUpdate(
      req.params.id,
      req.body,
      { new: true }
    );
    if (!updatedStudent) {
      return res.status(404).json({ errorMessage: "Student not found." });
    }
    res.status(200).json({
      success: true,
      data: updatedStudent,
      message: "Student updated successfully!",
    });
  } catch (error) {
    res.status(400).json({ errorMessage: error.message });
  }
};

const read = async (req, res) => {
  try {
    const students = await Student.find({});
    res.status(200).json({ success: true, data: students });
  } catch (error) {
    res.status(400).json({ errorMessage: error.message });
  }
};

const remove = async (req, res) => {
  try {
    const deletedStudent = await Student.findByIdAndDelete(req.params.id);
    if (!deletedStudent) {
      return res.status(404).json({ errorMessage: "Student not found." });
    }
    res.status(200).json({
      success: true,
      message: "Student deleted successfully!",
    });
  } catch (error) {
    res.status(400).json({ errorMessage: error.message });
  }
};

const getStudent = async (req, res) => {
  try {
    const student = await Student.findById(req.params.id);
    if (!student) {
      return res.status(404).json({ errorMessage: "Student not found." });
    }

    res.status(200).json({ success: true, data: student });
  } catch (error) {
    res.status(400).json({ errorMessage: error.message });
  }
};

module.exports = {
  create,
  update,
  read,
  remove,
  getStudent,
};
