import { Route, Book } from "../models";
import express from "express";
import { createBook } from "../services/bookService";

const createBookHandler = (req: express.Request, res: express.Response) => {
  // extract book data members from request body
  const { title, author, publisher_id } = req.body;

  // verify that all required data members are present
  if (!title || !author || !publisher_id) {
    res.status(400).send("Missing required fields");
    return;
  }

  // create a new book object
  const book: Book = { title, author, publisher_id };

  // create the book
  createBook(book, (error: any, result: any) => {
    if (error) {
      res.status(500).send(error);
    } else {
      res.status(200).send(result);
    }
  });
};

const route: Route = {
  path: "/books",
  method: "POST",
  handler: createBookHandler,
};

export default route;
