import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Observable, BehaviorSubject } from 'rxjs';
import { LibraryBranchService } from '../../library-branch.service';

@Component({
  selector: 'app-book-detail',
  templateUrl: './book-detail.component.html',
  styleUrls: ['./book-detail.component.scss'],
})
export class BookDetailComponent implements OnInit {
  bookId: number;
  book$: Observable<any> = new BehaviorSubject(null);
  bookLoans$: Observable<any> = new BehaviorSubject(null);
  constructor(
    private libraryBranchService: LibraryBranchService,
    private route: ActivatedRoute
  ) {
    this.bookId = +(this.route.snapshot.paramMap.get('id') || '1');
    this.book$ = this.libraryBranchService.getBook(this.bookId);
    this.bookLoans$ = this.libraryBranchService.getBookLoans(this.bookId);
  }

  ngOnInit(): void {}
}
