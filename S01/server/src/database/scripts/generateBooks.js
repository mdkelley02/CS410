const libraryBranches = require("./libraryBranches.json");
const bookCopies = require("./bookCopies.json");
const bookLoans = require("./bookLoans.json");
const fs = require("fs");

// seed library_branch
let output = "INSERT INTO library_branch (name) VALUES\n";
libraryBranches.forEach((branch) => {
  output += `('${branch.name}'),\n`;
});
output = output.slice(0, -2);
output += ";\n\n";

// seed book copy
output += `INSERT INTO library_branch_book_copy (library_branch_id, book_id) VALUES\n`;
bookCopies.forEach((copy) => {
  output += `(${copy.library_branch_id}, ${copy.book_id}),\n`;
});
output = output.slice(0, -2);
output += ";\n\n";

// seeed book loans
output += `INSERT INTO library_branch_book_loan (library_branch_id, book_copy_id, borrower_id) VALUES\n`;
bookLoans.forEach((loan) => {
  output += `(${loan.library_branch_id}, ${loan.book_id}, ${loan.borrower_id}),\n`;
});
output = output.slice(0, -2);
output += ";\n\n";

fs.writeFileSync("./seed.sql", output);
