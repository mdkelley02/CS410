import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { BookCopiesResponse } from '../../../../../../../server/src/models';
import { LibraryBranchService } from '../../library-branch.service';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-library-branch-detail',
  templateUrl: './library-branch-detail.component.html',
  styleUrls: ['./library-branch-detail.component.scss'],
})
export class LibraryBranchDetailComponent implements OnInit {
  books$: Observable<BookCopiesResponse[]>;
  branchId: number;
  constructor(
    private libraryBranchService: LibraryBranchService,
    private route: ActivatedRoute
  ) {
    this.branchId = +(this.route.snapshot.paramMap.get('id') || '1');
    this.books$ = this.libraryBranchService.getLibraryBranchBooks(
      this.branchId
    );
  }

  ngOnInit(): void {}
}
