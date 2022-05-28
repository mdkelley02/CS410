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
    library_branch_book_copy.library_branch_id,
      library_branch_book_copy.book_copy_id,
      library_branch.name as 'library_branch',
      book.book_id,
    publisher.name as 'publisher',
      book.title,
      book.author
  FROM library_branch_book_copy
  INNER JOIN book using(book_id) 
  INNER JOIN publisher using(publisher_id)
  INNER JOIN library_branch using (library_branch_id)
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
    callback: DaoCallback
  ) {
    const sql = `
    insert into 
      library_branch_book_loan (library_branch_id, book_copy_id, borrower_id) 
    values 
      (?, ?, ?);`;
    const params = [libraryBranchId, bookCopyId, borrowerId];
    conn.query(sql, params, (error: any, result: any) => {
      if (error) {
        callback(error, null);
      } else {
        const sql = `SELECT due_date FROM ${TABLES.library_branch_book_loan} WHERE loan_id = ?`;
        const param = [result.insertId];
        conn.query(sql, param, callback);
      }
    });
  }

  // marks a book copy as returned.
  static returnBook(bookCopyId: number, result: DaoCallback) {
    const sql = `DELETE FROM ${TABLES.library_branch_book_loan} WHERE book_copy_id = ?`;
    const params = [bookCopyId];
    conn.query(sql, params, result);
  }

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

  static getAllLoans(libraryBranchId: number, result: DaoCallback) {
    const sql = `SELECT 
    * 
    FROM ${TABLES.library_branch_book_loan} 
    INNER JOIN library_branch_book_copy USING (book_copy_id) 
    INNER JOIN book USING (book_id)
    WHERE library_branch_book_loan.library_branch_id = ?`;
    const params = [libraryBranchId];
    conn.query(sql, params, result);
  }
}
