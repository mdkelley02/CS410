import * as express from "express";

export interface Route {
  path: string;
  method: string;
  handler: express.RequestHandler;
}

export interface Config {
  port: string;
  db: {
    host: string;
    user: string;
    password: string;
    database: string;
    port: string;
  };
}

export interface Book {
  book_id?: number;
  title: string;
  author: string;
  publisher_id: number;
}

export interface Publisher {
  publisher_id?: number;
  name: string;
}

export interface Borrower {
  borrower_id?: number;
  name: string;
}

export interface LibraryBranch {
  library_branch_id?: number;
  branch_name: string;
}

export interface LibraryBranchBookCopies {
  library_branch_id?: number;
}

export type MysqlConnection = any;
