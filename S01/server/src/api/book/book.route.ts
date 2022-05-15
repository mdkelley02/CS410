import express from "express";
import BookController from "./book.controller";

const router = express.Router();

// creates a new book
// must be able to select n copies of the book to add
// must be able to select which library branches to add the book to
router.post("/", BookController.create);

router.get("/:bookId", BookController.getBook);
router.get("/:bookId/stock", BookController.getBookStock);

router.get("/", BookController.getAllBooks);

// lists all copies of a book from all library branches
router.get("/:bookId/copies", BookController.getAllBookCopies);

// Select a book, and list the number of copies checked out from each branch.
router.get("/:bookId/copies/count", BookController.getBookCheckouts);

export default router;
