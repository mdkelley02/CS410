import { TABLES } from "../database";
import { DaoCallback } from "../types";
import { conn } from "../database";
import { Book } from "../models";

export default class BookDao {
  static table = TABLES.book;
  static getBook(bookId: number, result: DaoCallback) {
    const sql = `SELECT book.book_id, book.publisher_id, book.title, book.author, publisher.name as 'publisher' FROM ${this.table} INNER JOIN publisher using (publisher_id) WHERE book_id = ?`;
    conn.query(sql, [bookId], result);
  }

  static getBookStock(bookId: number, result: DaoCallback) {
    const sql = `select 
      count(*) as 'count', library_branch.name, library_branch.library_branch_id
    from library_branch_book_copy
    inner join library_branch using (library_branch_id)
    where book_id = ?
    group by library_branch_book_copy.library_branch_id;`;
    const params = [bookId];
    conn.query(sql, [params], result);
  }

  static getAllBooks(result: DaoCallback) {
    const sql = `SELECT
    book_id,
    title,
    author,
    publisher_id,
    publisher.name as 'publisher'
    FROM ${TABLES.book}
    inner join ${TABLES.publisher} using (publisher_id)`;
    conn.query(sql, [], result);
  }
  // gets all copies of a book from all library branches
  static getAllBookCopies(bookId: number, result: DaoCallback) {
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
    where book_id = ?`;
    const params = [bookId];
    conn.query(sql, [params], result);
  }

  // creates a a new book
  // if numberOfCopies and libraryBranches are not provided, it will create
  // numberOfCopies copies of the book on the provided libraryBranches
  static create(
    book: Book,
    libraryBranches: number[] | undefined,
    numberOfCopies: number | undefined,
    callback: DaoCallback
  ) {
    let sql = `INSERT INTO ${TABLES.book} (title, author, publisher_id) VALUES (?, ?, ?)`;
    const params = [book.title, book.author, book.publisher_id];
    conn.query(sql, params, (error: any, result: any) => {
      if (error) {
        callback(error, null);
      } else {
        if (libraryBranches && numberOfCopies) {
          libraryBranches.forEach((libraryBranchId, index) => {
            const params = [];
            sql = `INSERT INTO ${TABLES.library_branch_book_copy} (book_id, library_branch_id) VALUES ?`;
            for (let i = 0; i < numberOfCopies; i++) {
              params.push([result.insertId, libraryBranchId]);
            }
            if (index === libraryBranches.length - 1) {
              conn.query(sql, [params], callback);
            } else {
              conn.query(sql, [params], (error: any, result: any) => {});
            }
          });
        } else {
          callback(error, result);
        }
      }
    });
  }
  //Select a book, and list the number of copies checked out from each branch.
  static getBookCheckouts(bookId: number, result: DaoCallback) {
    const sql = `select count(*) as 'number_of_loans', library_branch.name
    from library_branch_book_loan 
    inner join library_branch_book_copy using (book_copy_id)
    inner join library_branch on library_branch_book_loan.library_branch_id = library_branch.library_branch_id
    WHERE library_branch_book_copy.book_id = ? 
    GROUP BY library_branch.library_branch_id;`;
    const params = [bookId];
    conn.query(sql, [params], result);
  }
}
