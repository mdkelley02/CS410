export type Book = {
  book_id?: number;
  title: string;
  author: string;
  publisher_id: number;
};

export type BooksLoaned = {
  loan_id: number;
  book_id: number;
  title: string;
  author: string;
  library_branch_id: number;
  book_copy_id: number;
  borrower_id: number;
  loan_date: string;
  due_date: string;
  return_date: string;
};

export type BookResponse = {
  book_id: string;
  publisher_id: number;
  title: string;
  author: string;
  publisher: string;
};

export type BookLoansResponse = {
  number_of_loans: number;
  name: string;
};

export type BookStockResponse = {
  count: number;
  name: string;
  library_branch_id: number;
};

export type BookCopiesResponse = {
  book_copy_id: number;
  book_id: number;
  library_branch_id: number;
  library_branch: string;
  title: string;
  author: string;
  publisher: string;
};

export interface Publisher {
  publisher_id?: number;
  name: string;
}

export interface Borrower {
  borrower_id?: number;
  name: string;
}

export type LibraryBranch = {
  library_branch_id: string;
  name: string;
};

export interface LibraryBranchBookCopy {
  book_copy_id: number;
  book_id: number;
  library_branch_id: number;
  library_branch: string;
  title: string;
  author: string;
  publisher: string;
}

export type PublisherResponse = {
  publisher_id: number;
  name: string;
};
