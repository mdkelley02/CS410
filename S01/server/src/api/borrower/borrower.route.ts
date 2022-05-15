import express from "express";
import BorrowerController from "./borrower.controller";

const router = express.Router();

// lists all books
router.get("/", BorrowerController.getAll);
// creates a new book
router.post("/borrowId:/loans", BorrowerController.getAllLoanedBooks);

export default router;
