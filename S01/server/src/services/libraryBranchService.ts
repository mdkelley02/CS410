import { Borrower, Book } from "../models";
import { conn, TABLES } from "../database";
const MAX_COPIES = 10;
conn.connect();
/**
 * Creates a copy of a book and adds it to a library branch.
 * @param branchId the id of the branch to add the book to
 * @param bookId the id of the book to make a copy of
 * @param numCopies the number of copies to add to the branch
 */
const addBookToBranch = async (
  branchId: string,
  bookId: string,
  numCopies: number = 1,
  callback: (error: any, result: any) => void
) => {
  if (numCopies > MAX_COPIES) {
    callback(
      `Cannot add more than ${MAX_COPIES} copies to a library branch`,
      null
    );
    return;
  }
  const params = [];
  let query = `INSERT INTO ${TABLES.library_branch_book_copy} (book_id, library_branch_id, num_copies) VALUES`;
  for (let i = 0; i < numCopies; i++) {
    query += `(?, ?, ?)`;
    params.push(bookId, branchId, numCopies);
  }
  query += `;`;
  conn.query(query, params, (error: any, res: any) => {
    if (error) {
      callback(error, null);
    } else {
      callback(null, res);
    }
  });
};

/**
 * Checks a book copy out to a borrower.
 * @param bookCopyId the id of the book copy to check out
 * @param borrowerId the id of the borrower to check out the book to
 * @returns the date the book is due to be returned
 */
const checkoutBook = async (
  bookCopyId: string,
  borrowerId: string,
  callback: (error: any, result: any) => void
) => {
  const query = `INSERT INTO ${TABLES.library_branch_book_loan} (book_copy_id, borrower_id) VALUES (?, ?)`;
  const params = [bookCopyId, borrowerId];
  const result = await conn.query(query, params, (error: any, res: any) => {
    if (error) {
      callback(error, null);
    } else {
      const query = `select due_date from ${TABLES.library_branch_book_loan} where book_copy_id = ?`;
      const params = [bookCopyId];
      conn.query(query, params, (error: any, res: any) => {
        if (error) {
          callback(error, null);
        } else {
          if (res.length > 0) {
            callback(null, res[0].due_date);
          }
        }
      });
    }
  });
};

/**
 * Marks a book copy as returned.
 * @param bookCopyId the id of the book copy to mark as returned
 */
const markBookLoanReturned = async (
  bookCopyId: string,
  callback: (error: any, result: any) => void
) => {};

/**
 * Gets all books in a library branch.
 * @param branchId the id of the branch to get the books from
 */
const getBranchBooks = async (
  branchId: string,
  callback: (error: any, result: any) => void
) => {};

export { addBookToBranch, checkoutBook, markBookLoanReturned, getBranchBooks };
