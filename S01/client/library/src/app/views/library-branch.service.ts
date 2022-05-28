import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import {
  LibraryBranch,
  BookResponse,
  BookStockResponse,
  BookLoansResponse,
  BookCopiesResponse,
  Book,
  PublisherResponse,
  BooksLoaned,
  Borrower,
} from '../../../../../server/src/models';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root',
})
export class LibraryBranchService {
  private apiUrl = environment.apiUrl;

  constructor(private http: HttpClient) {}

  getLibraryBranches() {
    return this.http.get<LibraryBranch[]>(this.apiUrl + '/library');
  }

  getLibraryBranchBooks(id: number) {
    return this.http.get<BookCopiesResponse[]>(
      this.apiUrl + '/library/' + id + '/books'
    );
  }

  getBooks() {
    return this.http.get<BookResponse[]>(this.apiUrl + '/book');
  }

  getBook(id: number) {
    return this.http.get<BookResponse[]>(this.apiUrl + '/book/' + id);
  }

  getBookStock(id: number) {
    return this.http.get<BookStockResponse[]>(
      this.apiUrl + '/book/' + id + '/stock'
    );
  }

  getBookLoans(id: number) {
    return this.http.get<BookLoansResponse[]>(
      this.apiUrl + '/book/' + id + '/copies/count'
    );
  }

  createBook(book: Book, libraryBranches?: number[], numberOfCopies?: number) {
    console.log('called');
    type CreateBookRequest = {
      title: string;
      author: string;
      publisher_id: number;
      number_of_copies?: number;
      library_branches?: number[];
    };
    let body: CreateBookRequest;
    if (libraryBranches && numberOfCopies) {
      body = {
        title: book.title,
        author: book.author,
        publisher_id: book.publisher_id,
        number_of_copies: numberOfCopies,
        library_branches: libraryBranches,
      };
    } else {
      body = {
        title: book.title,
        author: book.author,
        publisher_id: book.publisher_id,
      };
    }
    return this.http.post(this.apiUrl + '/book', body);
  }

  getPublishers() {
    return this.http.get<PublisherResponse[]>(this.apiUrl + '/book/publisher');
  }

  getLibraryBranchLoanedBooks(id: number) {
    return this.http.get<BooksLoaned[]>(
      this.apiUrl + '/library/' + id + '/loans'
    );
  }

  checkoutBook(
    libraryBranchId: number,
    bookCopyId: number,
    borrowerId: number
  ) {
    return this.http.post(
      this.apiUrl + '/library/' + libraryBranchId + '/loans',
      {
        book_copy_id: bookCopyId,
        borrower_id: borrowerId,
      }
    );
  }

  returnBook(bookCopyId: number) {
    return this.http.post(this.apiUrl + '/library/loans/return', {
      book_copy_id: bookCopyId,
    });
  }

  getBorrowers() {
    return this.http.get<Borrower[]>(this.apiUrl + '/borrower');
  }
}
