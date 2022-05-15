import { TABLES } from "../database";
import { DaoCallback } from "../types";
import { conn } from "../database";
import { Book } from "../models";

export default class BorrowerDao {
  static table = TABLES.borrower;
  static getAll(result: DaoCallback) {
    const sql = `SELECT * FROM ${TABLES.borrower}`;
    conn.query(sql, [], result);
  }
  static getAllLoanedBooks(result: DaoCallback) {}
}
