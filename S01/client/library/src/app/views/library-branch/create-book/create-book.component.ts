import { Component, OnInit } from '@angular/core';
import {
  FormBuilder,
  FormControl,
  FormGroup,
  Validators,
} from '@angular/forms';
import { Observable } from 'rxjs';
import { LibraryBranchService } from '../../library-branch.service';
import {
  PublisherResponse,
  LibraryBranch,
  Book,
} from '../../../../../../../server/src/models';
import { Router } from '@angular/router';

@Component({
  selector: 'app-create-book',
  templateUrl: './create-book.component.html',
  styleUrls: ['./create-book.component.scss'],
})
export class CreateBookComponent implements OnInit {
  public publishers$: Observable<PublisherResponse[]>;
  public libraryBranches$: Observable<LibraryBranch[]>;
  public createBookForm: FormGroup;
  constructor(
    private libraryBranchService: LibraryBranchService,
    private formBuilder: FormBuilder,
    private router: Router
  ) {
    this.publishers$ = this.libraryBranchService.getPublishers();
    this.libraryBranches$ = this.libraryBranchService.getLibraryBranches();
    this.createBookForm = this.formBuilder.group({
      title: ['', Validators.required],
      author: ['', Validators.required],
      publisher: [0, Validators.required],
      libraryBranch: [undefined],
      numberOfCopies: [undefined],
    });
  }

  ngOnInit(): void {}

  onFormSubmit() {
    const { title, author, publisher, libraryBranch, numberOfCopies } =
      this.createBookForm.value;
    const book: Book = { title, author, publisher_id: publisher };
    if (!libraryBranch || !numberOfCopies) {
      this.libraryBranchService.createBook(book).subscribe(console.log);
    } else {
      this.libraryBranchService
        .createBook(book, libraryBranch, numberOfCopies)
        .subscribe(console.log);
    }
    this.router.navigate(['/']);
  }
}
