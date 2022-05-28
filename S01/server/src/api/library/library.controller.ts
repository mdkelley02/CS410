import { conn } from "../../database";
import LibraryDao from "../../dao/libraryDao";

export default class LibraryController {
  static getAllLibraryBranches = async (req: any, res: any) => {
    LibraryDao.getAllLibraryBranches((err: any, result: any) => {
      if (err) {
        res.status(500).send(err);
      } else {
        res.status(200).send(result);
      }
    });
  };

  // checkout a book
  static checkoutBook = async (req: any, res: any) => {
    const { libraryBranchId } = req.params;
    const { borrower_id, book_copy_id } = req.body;

    LibraryDao.checkoutBook(
      libraryBranchId,
      book_copy_id,
      borrower_id,
      (err: any, result: any) => {
        if (err) {
          res.status(500).send(err);
        } else {
          res.status(200).send(result.pop());
        }
      }
    );
  };

  // return a book
  static returnBook = async (req: any, res: any) => {
    const { book_copy_id } = req.body;
    LibraryDao.returnBook(book_copy_id, (err: any, result: any) => {
      if (err) {
        res.status(500).send(err);
      } else {
        res.status(200).send(result);
      }
    });
  };

  // gets all the book copies at a particular library branch
  static getAllBooks = async (req: any, res: any) => {
    LibraryDao.getAllBookCopies(
      req.params.libraryBranchId,
      (err: any, result: any) => {
        if (err) {
          res.status(500).send(err);
        } else {
          res.status(200).send(result);
        }
      }
    );
  };

  // Lists all loan belonging to a library branch
  static getAllLoans = async (req: any, res: any) => {
    LibraryDao.getAllLoans(
      req.params.libraryBranchId,
      (err: any, result: any) => {
        if (err) {
          res.status(500).send(err);
        } else {
          res.status(200).send(result);
        }
      }
    );
  };
}
