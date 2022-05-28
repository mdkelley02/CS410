import { Component, OnInit } from '@angular/core';
import { Observable, tap } from 'rxjs';
import {
  BookCopiesResponse,
  BooksLoaned,
  Borrower,
} from '../../../../../../../server/src/models';
import { LibraryBranchService } from '../../library-branch.service';
import { ActivatedRoute } from '@angular/router';
import {
  FormBuilder,
  FormControl,
  FormGroup,
  Validators,
} from '@angular/forms';

@Component({
  selector: 'app-library-branch-detail',
  templateUrl: './library-branch-detail.component.html',
  styleUrls: ['./library-branch-detail.component.scss'],
})
export class LibraryBranchDetailComponent {
  loanBookForm: FormGroup;
  loanedBooks$: Observable<BooksLoaned[]>;
  books$: Observable<BookCopiesResponse[]>;
  borrowers$: Observable<Borrower[]>;
  branchId: number;
  constructor(
    private libraryBranchService: LibraryBranchService,
    private route: ActivatedRoute,
    private formBuilder: FormBuilder
  ) {
    this.loanBookForm = this.formBuilder.group({
      borrowerId: ['', Validators.required],
      bookCopyId: ['', Validators.required],
    });
    this.branchId = +(this.route.snapshot.paramMap.get('id') || '1');
    this.borrowers$ = this.libraryBranchService.getBorrowers();
    this.books$ = this.libraryBranchService.getLibraryBranchBooks(
      this.branchId
    );
    this.loanedBooks$ = this.libraryBranchService.getLibraryBranchLoanedBooks(
      this.branchId
    );
  }

  public returnBook(bookCopyId: number): void {
    this.libraryBranchService
      .returnBook(bookCopyId)
      .pipe(
        tap(() => {
          this.loanedBooks$ =
            this.libraryBranchService.getLibraryBranchLoanedBooks(
              this.branchId
            );
        })
      )
      .subscribe();
  }

  public handleLoanBookSubmit(): void {
    console.log(this.loanBookForm.value);
    const { borrowerId, bookCopyId } = this.loanBookForm.value;
    this.libraryBranchService
      .checkoutBook(this.branchId, bookCopyId, borrowerId)
      .pipe(
        tap(() => {
          this.loanedBooks$ =
            this.libraryBranchService.getLibraryBranchLoanedBooks(
              this.branchId
            );
        })
      )
      .subscribe();
  }
}
