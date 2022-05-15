import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LibraryBranchDetailComponent } from './library-branch-detail.component';

describe('LibraryBranchDetailComponent', () => {
  let component: LibraryBranchDetailComponent;
  let fixture: ComponentFixture<LibraryBranchDetailComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ LibraryBranchDetailComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(LibraryBranchDetailComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
