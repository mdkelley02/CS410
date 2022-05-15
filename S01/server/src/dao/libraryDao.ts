import { TABLES } from "../database";
import { DaoCallback } from "../types";
import { conn } from "../database";
import { Book } from "../models";

export default class LibraryDao {
  static table = TABLES.library_branch;

  static getAllLibraryBranches(result: DaoCallback) {
    const sql = `SELECT * FROM ${TABLES.library_branch}`;
    conn.query(sql, [], result);
  }

  static getAllBookCopies(libraryBranchId: number, result: DaoCallback) {
    const sql = `SELECT
    book_copy_id,
    book_id,
    library_branch_id,
    library_branch.name as 'library_branch', 
    book.title, book.author, 
    publisher.name as 'publisher' 
    FROM ${TABLES.library_branch_book_copy} 
    inner join ${TABLES.book} using (book_id) 
    inner join ${TABLES.publisher} using (publisher_id)
    inner join ${TABLES.library_branch} using (library_branch_id) 
    where library_branch_id = ?`;
    const params = [libraryBranchId];
    conn.query(sql, [params], result);
  }

  // checkout a book from a library branch, and assign it to a borrower.
  // return in the callback the date when the book is due to be returned.
  static checkoutBook(
    libraryBranchId: number,
    bookCopyId: number,
    borrowerId: number,
    result: DaoCallback
  ) {}

  // marks a book copy as returned.
  static returnBook(bookCopyId: number, result: DaoCallback) {}

  // creates n number of books copies on a particular library branch
  static createBookCopy(
    bookId: number,
    libraryBranchId: number,
    numCopies: number,
    result: DaoCallback
  ) {
    const params = [];
    for (let i = 0; i < numCopies; i++) {
      params.push([bookId, libraryBranchId]);
    }
    const sql = `INSERT INTO ${TABLES.library_branch_book_copy} (book_id, library_branch_id) VALUES ?`;
    conn.query(sql, [params], result);
  }

  static getAllLoans(libraryBranchId: number, result: DaoCallback) {}
}
