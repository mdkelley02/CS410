import { Route, Book } from "../models";
import express from "express";
import { addBookToBranch } from "../services/libraryBranchService";
const url = require("url");

const createLibraryBranchBookCopyHandler = (
  req: express.Request,
  res: express.Response
) => {
  // get library branch id request parameter
  const branchId = req.params.libraryBranchId;

  // get number of copies to create from url query string
  const urlParts = url.parse(req.url, true);
  const query = urlParts.query;
  let numCopies = query?.copies;

  if (!numCopies) {
    numCopies = 1;
  }

  const { book_id } = req.body;
  if (!book_id) {
    res.status(400).send("Missing required fields");
    return;
  }

  addBookToBranch(branchId, book_id, numCopies, (error: any, result: any) => {
    if (error) {
      res.status(500).send(error);
    } else {
      res.status(200).send(result);
    }
  });
};

const route: Route = {
  path: "/library/:libraryBranchId/books",
  method: "POST",
  handler: createLibraryBranchBookCopyHandler,
};

export default route;
