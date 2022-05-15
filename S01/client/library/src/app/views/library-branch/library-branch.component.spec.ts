import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LibraryBranchComponent } from './library-branch.component';

describe('LibraryBranchComponent', () => {
  let component: LibraryBranchComponent;
  let fixture: ComponentFixture<LibraryBranchComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ LibraryBranchComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(LibraryBranchComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
