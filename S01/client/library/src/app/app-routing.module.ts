import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  {
    path: '',
    redirectTo: 'library',
    pathMatch: 'full',
  },
  {
    path: 'library',
    loadChildren: () =>
      import('./views/library-branch/library-branch.module').then(
        (m) => m.LibraryBranchModule
      ),
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
