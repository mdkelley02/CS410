import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LibraryBranchComponent } from './library-branch.component';
import { LibraryBranchDetailComponent } from './library-branch-detail/library-branch-detail.component';
import { BookDetailComponent } from './book-detail/book-detail.component';
import { CreateBookComponent } from './create-book/create-book.component';

const routes: Routes = [
  {
    path: '',
    component: LibraryBranchComponent,
  },
  {
    path: 'create-book',
    component: CreateBookComponent,
  },
  {
    path: ':id',
    component: LibraryBranchDetailComponent,
  },
  {
    path: 'book/:id',
    component: BookDetailComponent,
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class LibraryBranchRoutingModule {}
