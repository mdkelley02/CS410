import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatTableModule } from '@angular/material/table';
import { MatExpansionModule } from '@angular/material/expansion';

import { LibraryBranchRoutingModule } from './library-branch-routing.module';
import { LibraryBranchDetailComponent } from './library-branch-detail/library-branch-detail.component';
import { BookDetailComponent } from './book-detail/book-detail.component';
import { CreateBookComponent } from './create-book/create-book.component';

import { FormsModule, ReactiveFormsModule } from '@angular/forms';

@NgModule({
  declarations: [
    LibraryBranchDetailComponent,
    BookDetailComponent,
    CreateBookComponent,
  ],
  imports: [
    CommonModule,
    LibraryBranchRoutingModule,
    MatFormFieldModule,
    MatSelectModule,
    MatInputModule,
    MatCardModule,
    MatButtonModule,
    MatIconModule,
    FormsModule,
    ReactiveFormsModule,
    MatTableModule,
    MatExpansionModule,
  ],
})
export class LibraryBranchModule {}
