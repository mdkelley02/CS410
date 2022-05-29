<li>S01</li>
<li>CS 410 - Databases</li>
<li>May 28, 2022</li>
<li>Matthew Kelley</li>
<hr/>
<h2>Overview</h2>
<p>The following application is an elementary library admin interface for managing an enterprise of library branches.</p>
<h2>Getting Started</h2>
<p>Make sure the Node runtime and NPM package manager are installed.
<a>https://nodejs.org/en/download/</a></p>
<ol>
<li>Navigate to <code>server/</code></li>
<li>Install application dependencies <code>npm install</code></li>
<li> Naviate to <code>server/src/database/sql</code> run the setup sql script <code>setup.sql</code></li>
<li>Navigate to <code>server/</code> start the application <code>npm run start</code></li>
<li>Application will be running at <code>localhost:3000</code></li>
</ol>
<h2>Lessons Learned</h2>
<p>
    Not much in this project was new per se, however, it was a great learning opporunity to actually compile my previous learnings into a functional application (albeit elementary)
</p>
<p>
    Triggers were by far my largest obstacke. Initially I created an after insert tigger to set the loan due date for a book loan. Through some internet searching I learned that inserting a value during an after insert trigger would cause an infinite loop. I Eventually implemented the trigger using a before insert trigger so that before the book loan gets inserted into the table, the loan date is set accordingly.
</p>
<hr/>
<h2>Schema</h2>
<code>
<pre>
CREATE TABLE IF NOT EXISTS book (
    book_id INT AUTO_INCREMENT NOT NULL,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    publisher_id INT NOT NULL,
    PRIMARY KEY (book_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);
</pre>
<pre>
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (publisher_id)
);
</pre>
<pre>
CREATE TABLE borrower (
    borrower_id INT AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (borrower_id)
);
</pre>
<pre>
CREATE TABLE library_branch (
    library_branch_id INT AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (library_branch_id)
);
</pre>
<pre>
CREATE TABLE library_branch_book_copy (
    book_copy_id INT AUTO_INCREMENT,
    library_branch_id INT NOT NULL,
    book_id INT NOT NULL,
    PRIMARY KEY (book_copy_id),
    FOREIGN KEY (library_branch_id) REFERENCES library_branch(library_branch_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);
</pre>
<pre>
CREATE TABLE library_branch_book_loan (
    loan_id INT AUTO_INCREMENT NOT NULL,
    library_branch_id INT NOT NULL,
    book_copy_id INT NOT NULL,
    borrower_id INT NOT NULL,
    loan_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    due_date DATETIME,
    return_date DATETIME NULL,
    PRIMARY KEY (loan_id),
    FOREIGN KEY (library_branch_id) REFERENCES library_branch(library_branch_id),
    FOREIGN KEY (book_copy_id) REFERENCES library_branch_book_copy(book_copy_id),
    FOREIGN KEY (borrower_id) REFERENCES borrower(borrower_id)
);
</pre>
</code>
<hr/>
<h2>REST API Spec</h2>

<h4>Borrower</h4>
<ul>
    <li>
        <p>Lists all borrowers</p>
        <p><code>GET /borrower/</code></p>
    </li>
</ul>

<h4>library</h4>
<ul>
    <li>
        <p>Lists all library branches</p>
        <p><code>GET /library/</code></p>
    </li>
    <li>        
        <p>Lists all books belonging to a library branch</p>
        <p><code>GET /library/:libraryBranchId/books</code></p>
    </li>
    <li>        
        <p>Lists all loan belonging to a library branch</p>
        <p><code>GET /library/:libraryBranchId/loans</code></p>
    </li>
    <li>        
        <p>Creates a new book loan under the specified library branch</p>
        <p><code>POST /library/:libraryBranchId/loans</code></p>
        <code>
            <pre>
            {
                "borrower_id": 3,
                "book_copy_id": 2
            }
            </pre>
        </code>
    </li>
    <li>        
        <p>Marks a loan as returned</p>
        <p><code>POST /library/loans/return</code></p>
        <code>
            <pre>
            {
                "book_copy_id": 2
            }
            </pre>
        </code>
    </li>
</ul>

<h3>book</h3>
<ul>
    <li>
        <p>Creates a new book</p>
        <p><code>POST /book/</code></p>
        <p>Creates a book</p>
        <code>
            <pre>
                {
                    "title": "The Hobbit",
                    "author": "J.R. Tolkein",
                    "publisher_id": 4
                }
            </pre>
        </code>
         <p>Creates a book and adds n number of copies to each provided library branch</p>
        <code>
            <pre>
            {
                "title": "The Hobbit",
                "author": "J.R. Tolkein",
                "publisher_id": 4,
                "number_of_copies": 3,
                "library_branches": [4, 5]
            }</pre>
        </code>
    </li>
    <li>        
        <p>Lists all copies of a book from all library branches</p>
        <p><code>GET /book/:bookId/copies</code></p>
    </li>
        <li>        
        <p>Select a book, and list the number of copies checked out from each branch.</p>
        <p><code>GET /book/:bookId/count</code></p>
    </li>
</ul>