import { Book } from "../models";
import { conn, TABLES } from "../database";

conn.connect();
/**
 * Creates a new book
 * @param book
 */
const createBook = async (
  book: Book,
  result: (error: any, res: any) => void
) => {
  const query = `INSERT INTO ${TABLES.book} (title, author, publisher_id) VALUES (?, ?, ?)`;
  console.log(query);
  const params = [book.title, book.author, book.publisher_id];
  await conn.query(query, params, (error: any, res: any) => {
    if (error) {
      result(error, null);
    } else {
      result(null, res);
    }
  });
};

/**
 * Gets all copies of a book from all library branches
 * @param bookId the id of the book to get
 */
const getAllCopies = async (bookId: string) => {
  const query = `SELECT * FROM library_branch_book_copies WHERE book_id = ?`;
  const params = [bookId];
  const result = await conn.query(query, params);
  return result;
};

export { createBook, getAllCopies };
