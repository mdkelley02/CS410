import express from "express";
import BorrowerController from "./borrower.controller";

const router = express.Router();

// lists all borrowers
router.get("/", BorrowerController.getAll);

export default router;
