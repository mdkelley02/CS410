import { conn } from "../../database";
import BookDao from "../../dao/bookDao";
import { Book } from "../../models";

export default class BookController {
  static getAllPublishers = (req: any, res: any) => {
    BookDao.getAllPublishers((err: any, results: any) => {
      if (err) {
        res.status(500).json({ error: err });
      } else {
        res.json(results);
      }
    });
  };

  static getBookStock = async (req: any, res: any) => {
    const bookId = req.params.bookId;
    BookDao.getBookStock(bookId, (err: any, result: any) => {
      if (err) {
        res.status(500).send(err);
      } else {
        res.status(200).send(result);
      }
    });
  };
  // gets all copies of a book from all library branches
  static getAllBookCopies = async (req: any, res: any) => {
    const bookId = req.params.bookId;
    BookDao.getAllBookCopies(bookId, (err: any, result: any) => {
      if (err) {
        res.status(500).send(err);
      } else {
        res.status(200).send(result);
      }
    });
  };

  static getAllBooks = async (req: any, res: any) => {
    BookDao.getAllBooks((err: any, result: any) => {
      if (err) {
        res.status(500).send(err);
      } else {
        res.status(200).send(result);
      }
    });
  };

  static getBook = async (req: any, res: any) => {
    const bookId = req.params.bookId;
    BookDao.getBook(bookId, (err: any, result: any) => {
      if (err) {
        res.status(500).send(err);
      } else {
        res.status(200).send(result);
      }
    });
  };
  // creates a new book
  // must be able to select 1 - 10 copies of the book to add
  // must be able to select which library branches to add the book to
  static create = async (req: any, res: any) => {
    const { title, author, publisher_id } = req.body;
    const book = { title, author, publisher_id };

    const libraryBranches = req.body.library_branches;
    let numberOfCopies = req.body.number_of_copies;

    if (libraryBranches != undefined && numberOfCopies != undefined) {
      if (numberOfCopies > 10 || numberOfCopies < 1) {
        numberOfCopies = 1;
      }
      if (libraryBranches.length < 1) {
        res.status(400).send("Must select at least one library branch");
        return;
      }
    }

    BookDao.create(
      book,
      libraryBranches,
      numberOfCopies,
      (err: any, result: any) => {
        if (err) {
          res.status(500).send(err);
        } else {
          res.status(201).send(result);
        }
      }
    );
  };
  //Select a book, and list the number of copies checked out from each branch.
  static getBookCheckouts = async (req: any, res: any) => {
    const bookId = req.params.bookId;
    BookDao.getBookCheckouts(bookId, (err: any, result: any) => {
      if (err) {
        res.status(500).send(err);
      } else {
        res.status(200).send(result);
      }
    });
  };
}
