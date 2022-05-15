import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import {
  LibraryBranch,
  BookResponse,
  BookStockResponse,
  BookLoansResponse,
  BookCopiesResponse,
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
}
