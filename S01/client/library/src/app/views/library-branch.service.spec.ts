import { TestBed } from '@angular/core/testing';

import { LibraryBranchService } from './library-branch.service';

describe('LibraryBranchService', () => {
  let service: LibraryBranchService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(LibraryBranchService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
