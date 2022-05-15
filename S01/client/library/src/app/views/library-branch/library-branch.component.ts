import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import {
  LibraryBranch,
  BookResponse,
} from '../../../../../../server/src/models';
import { LibraryBranchService } from '../library-branch.service';

@Component({
  selector: 'app-library-branch',
  templateUrl: './library-branch.component.html',
  styleUrls: ['./library-branch.component.scss'],
})
export class LibraryBranchComponent implements OnInit {
  libraryBranches$: Observable<LibraryBranch[]>;
  books$: Observable<BookResponse[]>;

  constructor(private libraryBranchService: LibraryBranchService) {
    this.libraryBranches$ = this.libraryBranchService.getLibraryBranches();
    this.books$ = this.libraryBranchService.getBooks();
  }

  ngOnInit(): void {}
}
