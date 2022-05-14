const mysql = require("mysql");
import { config } from "../config";
import { MysqlConnection } from "../models";

const conn: MysqlConnection = mysql.createConnection({
  host: config.db.host,
  user: config.db.user,
  password: config.db.password,
  database: config.db.database,
  port: config.db.port,
});

const TABLES = {
  book: "book",
  publisher: "publisher",
  borrower: "borrower",
  library_branch: "library_branch",
  library_branch_book_copy: "library_branch_book_copy",
  library_branch_book_loan: "library_branch_book_loan",
} as const;

export { conn, TABLES };
