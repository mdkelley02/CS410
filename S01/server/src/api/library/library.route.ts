import express from "express";
import LibraryController from "./library.controller";

const router = express.Router();
// gets all library branches
router.get("/", LibraryController.getAllLibraryBranches);

//get all books belonging to a library branch
router.get("/:libraryBranchId/books", LibraryController.getAllBooks);

// Lists all loan belonging to a library branch
router.get("/:libraryBranchId/loans", LibraryController.getAllLoans);

// creates a new book loan
router.post("/:libraryBranchId/loans", LibraryController.checkoutBook);

// returns a book loan
router.post("/loans/return", LibraryController.returnBook);

export default router;
