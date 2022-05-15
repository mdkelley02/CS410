import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { LibraryBranchRoutingModule } from './library-branch-routing.module';
import { LibraryBranchDetailComponent } from './library-branch-detail/library-branch-detail.component';
import { BookDetailComponent } from './book-detail/book-detail.component';

@NgModule({
  declarations: [LibraryBranchDetailComponent, BookDetailComponent],
  imports: [CommonModule, LibraryBranchRoutingModule],
})
export class LibraryBranchModule {}
