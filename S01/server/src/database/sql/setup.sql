-- create database ==================================
DROP DATABASE IF EXISTS library;

CREATE DATABASE IF NOT EXISTS library;

use library;

-- create schema ==================================
SET
    FOREIGN_KEY_CHECKS = 0;

SET
    UNIQUE_CHECKS = 0;

-- book ==================================
DROP TABLE IF EXISTS book;
CREATE TABLE IF NOT EXISTS book (
    book_id INT AUTO_INCREMENT NOT NULL,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    publisher_id INT NOT NULL,
    PRIMARY KEY (book_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

-- book auditing
DROP TABLE IF EXISTS book_audit_log;
CREATE TABLE IF NOT EXISTS book_audit_log (
    audit_id INT AUTO_INCREMENT NOT NULL,
    book_id INT NOT NULL,
    old_book_data JSON,
    new_book_data JSON,
    dml_type ENUM('INSERT', 'UPDATE') NOT NULL,
    dml_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    dml_created_by VARCHAR(255) NOT NULL,
    PRIMARY KEY (audit_id, book_id)
);

DELIMITER $$ 
CREATE TRIGGER book_insert_trigger 
AFTER INSERT ON book FOR EACH ROW
BEGIN
    INSERT INTO book_audit_log (
        book_id,
        old_book_data,
        new_book_data,
        dml_type,
        dml_created_by
    )
    VALUES (
        NEW.book_id,
        NULL,
        JSON_OBJECT(
            'title', NEW.title,
            'author', NEW.author,
            'publisher_id', NEW.publisher_id
        ),
        'INSERT',
        CURRENT_USER
    );
END$$
DELIMITER ;

DELIMITER $$ 
CREATE TRIGGER book_update_trigger 
AFTER UPDATE ON book FOR EACH ROW
BEGIN
    INSERT INTO book_audit_log (
        book_id,
        old_book_data,
        new_book_data,
        dml_type,
        dml_created_by
    )
    VALUES (
        NEW.book_id,
        JSON_OBJECT(
            'title', OLD.title,
            'author', OLD.author,
            'publisher_id', OLD.publisher_id
        ),
        JSON_OBJECT(
            'title', NEW.title,
            'author', NEW.author,
            'publisher_id', NEW.publisher_id
        ),
        'UPDATE',
        CURRENT_USER
    );
END$$
DELIMITER ;

-- publisher ==================================
DROP TABLE IF EXISTS publisher;
CREATE TABLE IF NOT EXISTS publisher (
    publisher_id INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (publisher_id)
);
-- publisher auditing
DROP TABLE IF EXISTS publisher_audit_log;
CREATE TABLE IF NOT EXISTS publisher_audit_log (
    audit_id INT AUTO_INCREMENT NOT NULL,
    publisher_id INT NOT NULL,
    old_publisher_data JSON,
    new_publisher_data JSON,
    dml_type ENUM('INSERT', 'UPDATE') NOT NULL,
    dml_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    dml_created_by VARCHAR(255) NOT NULL,
    PRIMARY KEY (audit_id, publisher_id)
);

DELIMITER $$
CREATE TRIGGER publisher_insert_trigger
AFTER INSERT ON publisher FOR EACH ROW
BEGIN
    INSERT INTO publisher_audit_log (
        publisher_id,
        old_publisher_data,
        new_publisher_data,
        dml_type,
        dml_created_by
    )
    VALUES (
        NEW.publisher_id,
        NULL,
        JSON_OBJECT(
            'name', NEW.name
        ),
        'INSERT',
        CURRENT_USER
    );
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER publisher_update_trigger
AFTER UPDATE ON publisher FOR EACH ROW
BEGIN
    INSERT INTO publisher_audit_log (
        publisher_id,
        old_publisher_data,
        new_publisher_data,
        dml_type,
        dml_created_by
    )
    VALUES (
        NEW.publisher_id,
        JSON_OBJECT(
            'name', OLD.name
        ),
        JSON_OBJECT(
            'name', NEW.name
        ),
        'UPDATE',
        CURRENT_USER
    );
END$$
DELIMITER ;

-- borrower ==================================
DROP TABLE IF EXISTS borrower;
CREATE TABLE IF NOT EXISTS borrower (
    borrower_id INT AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (borrower_id)
);

-- borrower auditing
DROP TABLE IF EXISTS borrower_audit_log;
CREATE TABLE IF NOT EXISTS borrower_audit_log (
    audit_id INT AUTO_INCREMENT,
    borrower_id INT NOT NULL,
    old_borrower_data JSON,
    new_borrower_data JSON,
    dml_type ENUM('INSERT', 'UPDATE') NOT NULL,
    dml_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    dml_created_by VARCHAR(255) NOT NULL,
    PRIMARY KEY (audit_id, borrower_id)
);

DELIMITER $$
CREATE TRIGGER borrower_insert_trigger
AFTER INSERT ON borrower FOR EACH ROW
BEGIN
    INSERT INTO borrower_audit_log (
        borrower_id,
        old_borrower_data,
        new_borrower_data,
        dml_type,
        dml_created_by
    )
    VALUES (
        NEW.borrower_id,
        NULL,
        JSON_OBJECT(
            'name', NEW.name
        ),
        'INSERT',
        CURRENT_USER
    );
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER borrower_update_trigger
AFTER UPDATE ON borrower FOR EACH ROW
BEGIN
    INSERT INTO borrower_audit_log (
        borrower_id,
        old_borrower_data,
        new_borrower_data,
        dml_type,
        dml_created_by
    )
    VALUES (
        NEW.borrower_id,
        JSON_OBJECT(
            'name', OLD.name
        ),
        JSON_OBJECT(
            'name', NEW.name
        ),
        'UPDATE',
        CURRENT_USER
    );
END$$
DELIMITER ;

-- library branch ==================================
DROP TABLE IF EXISTS library_branch;
CREATE TABLE IF NOT EXISTS library_branch (
    library_branch_id INT AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (library_branch_id)
);

-- library branch auditing
DROP TABLE IF EXISTS library_branch_audit_log;
CREATE TABLE IF NOT EXISTS library_branch_audit_log (
    audit_id INT AUTO_INCREMENT,
    library_branch_id INT NOT NULL,
    old_library_branch_data JSON,
    new_library_branch_data JSON,
    dml_type ENUM('INSERT', 'UPDATE') NOT NULL,
    dml_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    dml_created_by VARCHAR(255) NOT NULL,
    PRIMARY KEY (audit_id, library_branch_id)
);

DELIMITER $$
CREATE TRIGGER library_branch_insert_trigger
AFTER INSERT ON library_branch FOR EACH ROW
BEGIN
    INSERT INTO library_branch_audit_log (
        library_branch_id,
        old_library_branch_data,
        new_library_branch_data,
        dml_type,
        dml_created_by
    )
    VALUES (
        NEW.library_branch_id,
        NULL,
        JSON_OBJECT(
            'name', NEW.name
        ),
        'INSERT',
        CURRENT_USER
    );
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER library_branch_update_trigger
AFTER UPDATE ON library_branch FOR EACH ROW
BEGIN
    INSERT INTO library_branch_audit_log (
        library_branch_id,
        old_library_branch_data,
        new_library_branch_data,
        dml_type,
        dml_created_by
    )
    VALUES (
        NEW.library_branch_id,
        JSON_OBJECT(
            'name', OLD.name
        ),
        JSON_OBJECT(
            'name', NEW.name
        ),
        'UPDATE',
        CURRENT_USER
    );
END$$
DELIMITER ;

-- library branch book copy ==================================
DROP TABLE IF EXISTS library_branch_book_copy;
CREATE TABLE IF NOT EXISTS library_branch_book_copy (
    book_copy_id INT AUTO_INCREMENT,
    library_branch_id INT NOT NULL,
    book_id INT NOT NULL,
    PRIMARY KEY (book_copy_id),
    FOREIGN KEY (library_branch_id) REFERENCES library_branch(library_branch_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- library branch book copy auditing
DROP TABLE IF EXISTS library_branch_book_copy_audit_log;
CREATE TABLE IF NOT EXISTS library_branch_book_copy_audit_log (
    audit_id INT AUTO_INCREMENT,
    book_copy_id INT NOT NULL,
    old_library_branch_book_copy_data JSON,
    new_library_branch_book_copy_data JSON,
    dml_type ENUM('INSERT', 'UPDATE') NOT NULL,
    dml_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    dml_created_by VARCHAR(255) NOT NULL,
    PRIMARY KEY (audit_id, book_copy_id)
);

DELIMITER $$
CREATE TRIGGER library_branch_book_copy_insert_trigger
AFTER INSERT ON library_branch_book_copy FOR EACH ROW
BEGIN
    INSERT INTO library_branch_book_copy_audit_log (
        book_copy_id,
        old_library_branch_book_copy_data,
        new_library_branch_book_copy_data,
        dml_type,
        dml_created_by
    )
    VALUES (
        NEW.book_copy_id,
        NULL,
        JSON_OBJECT(
            'library_branch_id', NEW.library_branch_id,
            'book_id', NEW.book_id
        ),
        'INSERT',
        CURRENT_USER
    );
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER library_branch_book_copy_update_trigger
AFTER UPDATE ON library_branch_book_copy FOR EACH ROW
BEGIN
    INSERT INTO library_branch_book_copy_audit_log (
        book_copy_id,
        old_library_branch_book_copy_data,
        new_library_branch_book_copy_data,
        dml_type,
        dml_created_by
    )
    VALUES (
        NEW.book_copy_id,
        JSON_OBJECT(
            'library_branch_id', OLD.library_branch_id,
            'book_id', OLD.book_id
        ),
        JSON_OBJECT(
            'library_branch_id', NEW.library_branch_id,
            'book_id', NEW.book_id
        ),
        'UPDATE',
        CURRENT_USER
    );
END$$
DELIMITER ;

-- library branch book loan ==================================
DROP TABLE IF EXISTS library_branch_book_loan;
CREATE TABLE IF NOT EXISTS library_branch_book_loan (
    loan_id INT AUTO_INCREMENT NOT NULL,
    library_branch_id INT NOT NULL,
    book_copy_id INT NOT NULL,
    borrower_id INT NOT NULL,
    loan_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    due_date DATETIME,
    PRIMARY KEY (loan_id),
    FOREIGN KEY (library_branch_id) REFERENCES library_branch(library_branch_id),
    FOREIGN KEY (book_copy_id) REFERENCES library_branch_book_copy(book_copy_id),
    FOREIGN KEY (borrower_id) REFERENCES borrower(borrower_id)
);

-- library branch book loan auditing
DROP TABLE IF EXISTS library_branch_book_loan_audit_log;
CREATE TABLE IF NOT EXISTS library_branch_book_loan_audit_log (
    audit_id INT AUTO_INCREMENT NOT NULL,
    loan_id INT NOT NULL,
    old_loan_data JSON,
    new_loan_data JSON,
    dml_type ENUM('INSERT', 'UPDATE') NOT NULL,
    dml_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    dml_created_by VARCHAR(255) NOT NULL,
    PRIMARY KEY (audit_id, loan_id)
);

DELIMITER $$ 
CREATE TRIGGER library_branch_book_loan_insert_trigger 
AFTER INSERT ON library_branch_book_loan FOR EACH ROW
BEGIN
    INSERT INTO library_branch_book_loan_audit_log (
        loan_id,
        old_loan_data,
        new_loan_data,
        dml_type,
        dml_created_by
    )
    VALUES (
        NEW.loan_id,
        NULL,
        JSON_OBJECT(
            'loan_id', NEW.loan_id,
            'library_branch_id', NEW.library_branch_id,
            'book_copy_id', NEW.book_copy_id,
            'borrower_id', NEW.borrower_id,
            'loan_date', NEW.loan_date,
            'due_date', NEW.due_date
        ),
        'INSERT',
        CURRENT_USER
    );
END$$
DELIMITER ;

DELIMITER $$ 
CREATE TRIGGER library_branch_book_loan_update_trigger 
AFTER UPDATE ON library_branch_book_loan FOR EACH ROW
BEGIN
    INSERT INTO library_branch_book_loan_audit_log (
        loan_id,
        old_loan_data,
        new_loan_data,
        dml_type,
        dml_created_by
    )
    VALUES (
        NEW.loan_id,
        JSON_OBJECT(
            'loan_id', OLD.loan_id,
            'library_branch_id', OLD.library_branch_id,
            'book_copy_id', OLD.book_copy_id,
            'borrower_id', OLD.borrower_id,
            'loan_date', OLD.loan_date,
            'due_date', OLD.due_date
        ),
        JSON_OBJECT(
            'loan_id', NEW.loan_id,
            'library_branch_id', NEW.library_branch_id,
            'book_copy_id', NEW.book_copy_id,
            'borrower_id', NEW.borrower_id,
            'loan_date', NEW.loan_date,
            'due_date', NEW.due_date
        ),
        'UPDATE',
        CURRENT_USER
    );
END$$
DELIMITER ;

-- create book loan due date trigger
DELIMITER $$ 
CREATE TRIGGER before_library_branch_book_loan_insert 
BEFORE INSERT
ON library_branch_book_loan FOR EACH ROW 
BEGIN
    SET NEW.due_date = DATE_ADD(NEW.loan_date, INTERVAL 14 DAY);
END $$ 
DELIMITER ;

-- seed tables ==================================
SET
    FOREIGN_KEY_CHECKS = 1;

SET
    UNIQUE_CHECKS = 1;

-- seed publisher
INSERT INTO
    publisher (name)
VALUES
    ('HarperCollins'),
    ('Penguin'),
    ('Hachette Livre'),
    ('Simon & Schuster'),
    ('Houghton Mifflin'),
    ('W.W. Norton & Company'),
    ('Pearson'),
    ('Random House'),
    ('Bantam book'),
    ('Vintage book'),
    ('Doubleday'),
    ('Tor book'),
    ('Scholastic'),
    ('G.P. Putnam''s Sons'),
    ('Harper Paperbacks'),
    ('Ballantine book'),
    ('Random House Trade Paperbacks'),
    ('Penguin book'),
    ('Penguin Random House');

-- seed borrower
INSERT INTO
    borrower (name)
VALUES
    ('John Doe'),
    ('Mike Lynott'),
    ('Matthew Kelley'),
    ('Linus Torvalds'),
    ('Moe Lester'),
    ('Wayne Ker'),
    ('Jenny Tayla'),
    ('Harry Johnson'),
    ('Mike Crotch'),
    ('I.P Freely'),
    ('I.C. Weiner');

-- seed book table
insert into
    book (title, author, publisher_id)
values
    ('Things Fall Apart', 'Chinua Achebe', 2),
    ('Fairy tales', 'Hans Christian Andersen', 17),
    ('The Divine Comedy', 'Dante Alighieri', 11),
    ('The Epic Of Gilgamesh', 'Unknown', 4),
    ('The Book Of Job', 'Unknown', 5),
    ('One Thousand and One Nights', 'Unknown', 3),
    ('Nj??l''s Saga', 'Unknown', 13),
    ('Pride and Prejudice', 'Jane Austen', 16),
    ('Le P??re Goriot', 'Honor?? de Balzac', 5),
    (
        'Molloy, Malone Dies, The Unnamable, the trilogy',
        'Samuel Beckett',
        16
    ),
    ('The Decameron', 'Giovanni Boccaccio', 13),
    ('Ficciones', 'Jorge Luis Borges', 10),
    ('Wuthering Heights', 'Emily Bront??', 1),
    ('The Stranger', 'Albert Camus', 3),
    ('Poems', 'Paul Celan', 4),
    (
        'Journey to the End of the Night',
        'Louis-Ferdinand C??line',
        8
    ),
    (
        'Don Quijote De La Mancha',
        'Miguel de Cervantes',
        1
    ),
    ('The Canterbury Tales', 'Geoffrey Chaucer', 11),
    ('Stories', 'Anton Chekhov', 1),
    ('Nostromo', 'Joseph Conrad', 11),
    ('Great Expectations', 'Charles Dickens', 14),
    ('Jacques the Fatalist', 'Denis Diderot', 12),
    ('Berlin Alexanderplatz', 'Alfred D??blin', 13),
    ('Crime and Punishment', 'Fyodor Dostoevsky', 2),
    ('The Idiot', 'Fyodor Dostoevsky', 19),
    ('The Possessed', 'Fyodor Dostoevsky', 16),
    (
        'The Brothers Karamazov',
        'Fyodor Dostoevsky',
        12
    ),
    ('Middlemarch', 'George Eliot', 6),
    ('Invisible Man', 'Ralph Ellison', 14),
    ('Medea', 'Euripides', 18),
    ('Absalom, Absalom!', 'William Faulkner', 8),
    ('The Sound and the Fury', 'William Faulkner', 6),
    ('Madame Bovary', 'Gustave Flaubert', 5),
    ('Sentimental Education', 'Gustave Flaubert', 4),
    ('Gypsy Ballads', 'Federico Garc??a Lorca', 4),
    (
        'One Hundred Years of Solitude',
        'Gabriel Garc??a M??rquez',
        18
    ),
    (
        'Love in the Time of Cholera',
        'Gabriel Garc??a M??rquez',
        14
    ),
    ('Faust', 'Johann Wolfgang von Goethe', 2),
    ('Dead Souls', 'Nikolai Gogol', 13),
    ('The Tin Drum', 'G??nter Grass', 11),
    (
        'The Devil to Pay in the Backlands',
        'Jo??o Guimar??es Rosa',
        10
    ),
    ('Hunger', 'Knut Hamsun', 7),
    ('The Old Man and the Sea', 'Ernest Hemingway', 2),
    ('Iliad', 'Homer', 7),
    ('Odyssey', 'Homer', 10),
    ('A Doll''s House', 'Henrik Ibsen', 17),
    ('Ulysses', 'James Joyce', 2),
    ('Stories', 'Franz Kafka', 18),
    ('The Trial', 'Franz Kafka', 4),
    ('The Castle', 'Franz Kafka', 15),
    ('The recognition of Shakuntala', 'K??lid??sa', 13),
    (
        'The Sound of the Mountain',
        'Yasunari Kawabata',
        14
    ),
    ('Zorba the Greek', 'Nikos Kazantzakis', 15),
    ('Sons and Lovers', 'D. H. Lawrence', 6),
    ('Independent People', 'Halld??r Laxness', 6),
    ('Poems', 'Giacomo Leopardi', 11),
    ('The Golden Notebook', 'Doris Lessing', 7),
    ('Pippi Longstocking', 'Astrid Lindgren', 15),
    ('Diary of a Madman', 'Lu Xun', 16),
    ('Children of Gebelawi', 'Naguib Mahfouz', 10),
    ('Buddenbrooks', 'Thomas Mann', 7),
    ('The Magic Mountain', 'Thomas Mann', 12),
    ('Moby Dick', 'Herman Melville', 2),
    ('Essays', 'Michel de Montaigne', 12),
    ('History', 'Elsa Morante', 10),
    ('Beloved', 'Toni Morrison', 17),
    ('The Tale of Genji', 'Murasaki Shikibu', 19),
    ('The Man Without Qualities', 'Robert Musil', 4),
    ('Lolita', 'Vladimir Nabokov', 5),
    ('Nineteen Eighty-Four', 'George Orwell', 9),
    ('Metamorphoses', 'Ovid', 17),
    ('The Book of Disquiet', 'Fernando Pessoa', 7),
    ('Tales', 'Edgar Allan Poe', 18),
    ('In Search of Lost Time', 'Marcel Proust', 8),
    (
        'Gargantua and Pantagruel',
        'Fran??ois Rabelais',
        3
    ),
    ('Pedro P??ramo', 'Juan Rulfo', 19),
    ('The Masnavi', 'Rumi', 10),
    ('Midnight''s Children', 'Salman Rushdie', 10),
    ('Bostan', 'Saadi', 4),
    (
        'Season of Migration to the North',
        'Tayeb Salih',
        11
    ),
    ('Blindness', 'Jos?? Saramago', 3),
    ('Hamlet', 'William Shakespeare', 18),
    ('King Lear', 'William Shakespeare', 12),
    ('Othello', 'William Shakespeare', 2),
    ('Oedipus the King', 'Sophocles', 11),
    ('The Red and the Black', 'Stendhal', 13),
    (
        'The Life And Opinions of Tristram Shandy',
        'Laurence Sterne',
        19
    ),
    ('Confessions of Zeno', 'Italo Svevo', 16),
    ('Gulliver''s Travels', 'Jonathan Swift', 16),
    ('War and Peace', 'Leo Tolstoy', 6),
    ('Anna Karenina', 'Leo Tolstoy', 5),
    ('The Death of Ivan Ilyich', 'Leo Tolstoy', 10),
    (
        'The Adventures of Huckleberry Finn',
        'Mark Twain',
        9
    ),
    ('Ramayana', 'Valmiki', 2),
    ('The Aeneid', 'Virgil', 9),
    ('Mahabharata', 'Vyasa', 18),
    ('Leaves of Grass', 'Walt Whitman', 8),
    ('Mrs Dalloway', 'Virginia Woolf', 2),
    ('To the Lighthouse', 'Virginia Woolf', 7),
    ('Memoirs of Hadrian', 'Marguerite Yourcenar', 18);

-- seed library_branch
INSERT INTO
    library_branch (name)
VALUES
    ('Boise Library'),
    ('Caldwell Library'),
    ('Meridian Library'),
    ('Star Library'),
    ('Eagle Library'),
    ('Idaho Falls Library'),
    ('Pocatello Library'),
    ('Twin Falls Library'),
    ('Coeur d''Alene Library');

-- seed library_branch_book_copy
INSERT INTO
    library_branch_book_copy (library_branch_id, book_id)
VALUES
    (1, 7),
    (1, 7),
    (1, 1),
    (1, 1),
    (1, 1),
    (1, 15),
    (1, 15),
    (1, 4),
    (1, 4),
    (1, 4),
    (1, 4),
    (1, 4),
    (1, 4),
    (1, 4),
    (1, 3),
    (1, 3),
    (1, 2),
    (1, 2),
    (1, 9),
    (1, 12),
    (1, 12),
    (1, 12),
    (1, 11),
    (1, 11),
    (1, 11),
    (1, 15),
    (1, 15),
    (1, 6),
    (1, 6),
    (1, 6),
    (1, 8),
    (1, 8),
    (2, 42),
    (2, 42),
    (2, 42),
    (2, 19),
    (2, 3),
    (2, 3),
    (2, 31),
    (2, 31),
    (2, 31),
    (2, 20),
    (2, 20),
    (2, 20),
    (2, 12),
    (2, 36),
    (2, 36),
    (2, 25),
    (2, 25),
    (2, 25),
    (2, 40),
    (2, 45),
    (2, 45),
    (2, 45),
    (2, 22),
    (2, 35),
    (2, 36),
    (2, 7),
    (2, 3),
    (2, 3),
    (2, 19),
    (2, 19),
    (2, 38),
    (2, 43),
    (2, 43),
    (2, 9),
    (2, 35),
    (2, 35),
    (2, 35),
    (2, 31),
    (2, 31),
    (2, 25),
    (2, 25),
    (2, 44),
    (2, 44),
    (2, 44),
    (2, 29),
    (2, 2),
    (2, 40),
    (2, 14),
    (2, 14),
    (2, 14),
    (2, 22),
    (2, 22),
    (2, 22),
    (2, 36),
    (2, 36),
    (2, 30),
    (2, 30),
    (2, 10),
    (2, 10),
    (2, 10),
    (2, 25),
    (2, 25),
    (2, 6),
    (2, 28),
    (2, 14),
    (2, 33),
    (2, 43),
    (2, 43),
    (2, 43),
    (2, 39),
    (2, 39),
    (2, 39),
    (2, 42),
    (2, 42),
    (2, 42),
    (2, 35),
    (2, 10),
    (2, 10),
    (2, 10),
    (2, 30),
    (2, 16),
    (2, 16),
    (2, 16),
    (2, 33),
    (2, 33),
    (2, 35),
    (2, 35),
    (2, 39),
    (3, 62),
    (3, 62),
    (3, 79),
    (3, 79),
    (3, 61),
    (3, 61),
    (3, 57),
    (3, 57),
    (3, 57),
    (3, 58),
    (3, 66),
    (3, 41),
    (3, 41),
    (3, 2),
    (3, 2),
    (3, 52),
    (3, 52),
    (3, 52),
    (3, 31),
    (3, 31),
    (3, 18),
    (3, 18),
    (3, 18),
    (3, 55),
    (3, 55),
    (3, 57),
    (3, 8),
    (3, 8),
    (3, 49),
    (3, 49),
    (3, 49),
    (3, 72),
    (3, 72),
    (3, 33),
    (3, 33),
    (3, 33),
    (3, 68),
    (3, 68),
    (3, 68),
    (3, 74),
    (3, 27),
    (3, 27),
    (3, 27),
    (3, 27),
    (3, 27),
    (3, 70),
    (3, 23),
    (3, 79),
    (3, 79),
    (3, 27),
    (3, 44),
    (3, 10),
    (3, 10),
    (3, 76),
    (3, 76),
    (3, 71),
    (3, 10),
    (3, 50),
    (3, 50),
    (3, 43),
    (3, 43),
    (3, 43),
    (3, 71),
    (3, 71),
    (3, 71),
    (3, 6),
    (3, 6),
    (3, 28),
    (3, 28),
    (3, 60),
    (3, 60),
    (3, 1),
    (3, 1),
    (3, 1),
    (3, 68),
    (3, 16),
    (3, 16),
    (3, 16),
    (3, 46),
    (3, 46),
    (3, 46),
    (3, 73),
    (3, 73),
    (3, 16),
    (3, 16),
    (3, 16),
    (3, 64),
    (3, 64),
    (3, 57),
    (3, 58),
    (3, 52),
    (3, 22),
    (3, 40),
    (3, 65),
    (3, 65),
    (3, 64),
    (3, 64),
    (3, 64),
    (3, 1),
    (3, 45),
    (3, 45),
    (3, 45),
    (3, 28),
    (3, 28),
    (3, 18),
    (3, 18),
    (3, 27),
    (3, 27),
    (3, 27),
    (3, 76),
    (3, 25),
    (3, 25),
    (3, 25),
    (3, 12),
    (3, 12),
    (3, 12),
    (3, 63),
    (3, 63),
    (3, 63),
    (3, 59),
    (3, 59),
    (3, 59),
    (3, 60),
    (3, 60),
    (3, 60),
    (3, 14),
    (3, 55),
    (3, 72),
    (3, 72),
    (3, 18),
    (3, 18),
    (3, 18),
    (3, 43),
    (3, 43),
    (3, 43),
    (3, 41),
    (3, 11),
    (3, 11),
    (3, 14),
    (3, 14),
    (3, 14),
    (3, 64),
    (3, 64),
    (3, 16),
    (3, 16),
    (3, 39),
    (3, 39),
    (3, 39),
    (3, 77),
    (3, 77),
    (3, 77),
    (3, 20),
    (3, 60),
    (3, 77),
    (3, 77),
    (3, 52),
    (3, 31),
    (3, 31),
    (3, 73),
    (4, 47),
    (4, 86),
    (4, 86),
    (4, 63),
    (4, 63),
    (4, 63),
    (4, 66),
    (4, 66),
    (4, 63),
    (4, 29),
    (4, 29),
    (4, 44),
    (4, 44),
    (4, 88),
    (4, 88),
    (4, 88),
    (4, 26),
    (4, 26),
    (4, 26),
    (4, 51),
    (4, 51),
    (4, 55),
    (4, 55),
    (4, 55),
    (4, 47),
    (4, 47),
    (4, 47),
    (4, 61),
    (4, 49),
    (4, 49),
    (4, 50),
    (4, 77),
    (4, 77),
    (4, 77),
    (4, 93),
    (4, 36),
    (4, 36),
    (4, 36),
    (4, 46),
    (4, 46),
    (4, 38),
    (4, 73),
    (4, 73),
    (4, 7),
    (4, 56),
    (4, 39),
    (4, 12),
    (4, 75),
    (4, 19),
    (4, 19),
    (4, 19),
    (4, 38),
    (4, 86),
    (4, 15),
    (4, 30),
    (4, 57),
    (4, 57),
    (4, 80),
    (4, 80),
    (4, 57),
    (4, 57),
    (4, 57),
    (4, 95),
    (4, 72),
    (4, 72),
    (4, 88),
    (4, 45),
    (4, 5),
    (4, 5),
    (4, 60),
    (4, 60),
    (4, 60),
    (4, 34),
    (4, 83),
    (4, 83),
    (4, 81),
    (4, 81),
    (4, 10),
    (4, 10),
    (4, 10),
    (4, 34),
    (4, 34),
    (4, 38),
    (4, 38),
    (4, 32),
    (4, 32),
    (4, 32),
    (4, 12),
    (4, 37),
    (4, 20),
    (4, 51),
    (4, 51),
    (4, 51),
    (4, 95),
    (4, 95),
    (4, 90),
    (4, 90),
    (4, 37),
    (4, 20),
    (4, 20),
    (4, 7),
    (4, 84),
    (4, 84),
    (4, 84),
    (4, 41),
    (4, 41),
    (4, 41),
    (4, 41),
    (4, 4),
    (4, 4),
    (4, 61),
    (4, 61),
    (4, 61),
    (4, 3),
    (4, 3),
    (4, 20),
    (4, 20),
    (4, 43),
    (4, 43),
    (4, 85),
    (4, 27),
    (4, 82),
    (4, 45),
    (4, 57),
    (4, 57),
    (4, 82),
    (4, 82),
    (4, 88),
    (4, 88),
    (4, 88),
    (4, 82),
    (4, 82),
    (4, 84),
    (4, 84),
    (4, 58),
    (4, 79),
    (4, 79),
    (4, 23),
    (4, 68),
    (4, 93),
    (4, 93),
    (4, 93),
    (4, 71),
    (4, 71),
    (4, 21),
    (4, 21),
    (4, 21),
    (4, 44),
    (4, 44),
    (4, 65),
    (4, 65),
    (4, 65),
    (4, 78),
    (4, 73),
    (4, 62),
    (4, 83),
    (4, 83),
    (4, 83),
    (4, 93),
    (4, 93),
    (4, 93),
    (4, 18),
    (4, 18),
    (4, 18),
    (4, 93),
    (4, 93),
    (4, 93),
    (4, 73),
    (4, 73),
    (4, 31),
    (4, 31),
    (4, 64),
    (4, 1),
    (4, 8),
    (4, 53),
    (6, 2),
    (6, 2),
    (6, 5),
    (6, 5),
    (6, 5),
    (6, 2),
    (6, 1),
    (6, 2),
    (6, 2),
    (6, 2),
    (7, 23),
    (7, 36),
    (7, 29),
    (7, 29),
    (7, 29),
    (7, 14),
    (7, 17),
    (7, 37),
    (7, 37),
    (7, 37),
    (7, 13),
    (7, 23),
    (7, 3),
    (7, 3),
    (7, 3),
    (7, 4),
    (7, 4),
    (7, 4),
    (7, 33),
    (7, 33),
    (7, 37),
    (7, 37),
    (7, 37),
    (7, 37),
    (7, 19),
    (7, 19),
    (7, 27),
    (7, 27),
    (7, 14),
    (7, 14),
    (7, 32),
    (7, 21),
    (7, 21),
    (7, 21),
    (7, 26),
    (7, 26),
    (7, 26),
    (7, 16),
    (7, 16),
    (7, 13),
    (7, 4),
    (7, 7),
    (7, 17),
    (7, 27),
    (7, 27),
    (7, 29),
    (7, 20),
    (7, 20),
    (7, 20),
    (7, 34),
    (7, 34),
    (7, 34),
    (7, 4),
    (7, 19),
    (7, 19),
    (7, 19),
    (7, 36),
    (7, 33),
    (7, 33),
    (7, 22),
    (7, 22),
    (7, 15),
    (7, 15),
    (7, 25),
    (7, 10),
    (7, 14),
    (7, 14),
    (7, 14),
    (8, 42),
    (8, 42),
    (8, 42),
    (8, 9),
    (8, 9),
    (8, 9),
    (8, 34),
    (8, 42),
    (8, 42),
    (8, 42),
    (8, 36),
    (8, 43),
    (8, 43),
    (8, 43),
    (8, 41),
    (8, 43),
    (8, 43),
    (8, 29),
    (8, 29),
    (8, 29),
    (8, 58),
    (8, 28),
    (8, 11),
    (8, 11),
    (8, 11),
    (8, 10),
    (8, 13),
    (8, 13),
    (8, 13),
    (8, 33),
    (8, 33),
    (8, 33),
    (8, 52),
    (8, 1),
    (8, 1),
    (8, 47),
    (8, 47),
    (8, 47),
    (8, 14),
    (8, 14),
    (8, 14),
    (8, 24),
    (8, 9),
    (8, 9),
    (8, 9),
    (8, 7),
    (8, 7),
    (8, 7),
    (8, 57),
    (8, 57),
    (8, 56),
    (8, 39),
    (8, 39),
    (8, 39),
    (8, 23),
    (8, 51),
    (8, 51),
    (8, 23),
    (8, 23),
    (8, 23),
    (8, 33),
    (8, 33),
    (8, 33),
    (8, 27),
    (8, 7),
    (8, 7),
    (8, 5),
    (8, 5),
    (8, 5),
    (8, 21),
    (8, 21),
    (8, 21),
    (8, 6),
    (8, 6),
    (8, 46),
    (8, 46),
    (8, 46),
    (8, 53),
    (8, 22),
    (8, 22),
    (8, 1),
    (8, 7),
    (8, 7),
    (8, 36),
    (8, 36),
    (8, 57),
    (8, 57),
    (8, 57),
    (8, 38),
    (8, 53),
    (8, 53),
    (8, 12),
    (8, 12),
    (8, 55),
    (8, 55),
    (8, 19),
    (8, 19),
    (8, 33),
    (8, 33),
    (8, 33),
    (8, 32),
    (8, 23),
    (8, 23),
    (8, 23),
    (8, 23),
    (8, 33),
    (8, 20),
    (8, 20),
    (8, 20),
    (8, 54),
    (8, 39),
    (8, 39),
    (8, 39),
    (8, 39),
    (8, 17),
    (8, 10),
    (8, 10),
    (8, 10),
    (8, 32),
    (8, 32),
    (8, 32),
    (9, 20),
    (9, 20),
    (9, 6),
    (9, 6),
    (9, 6),
    (9, 5),
    (9, 5),
    (9, 5),
    (9, 55),
    (9, 55),
    (9, 56),
    (9, 22),
    (9, 55),
    (9, 5),
    (9, 5),
    (9, 31),
    (9, 31),
    (9, 53),
    (9, 53),
    (9, 47),
    (9, 47),
    (9, 47),
    (9, 33),
    (9, 33),
    (9, 33),
    (9, 30),
    (9, 30),
    (9, 27),
    (9, 27),
    (9, 42),
    (9, 15),
    (9, 49),
    (9, 49),
    (9, 49),
    (9, 50),
    (9, 50),
    (9, 50),
    (9, 57),
    (9, 57),
    (9, 19),
    (9, 19),
    (9, 19),
    (9, 51),
    (9, 21),
    (9, 56),
    (9, 56),
    (9, 56),
    (9, 41),
    (9, 41),
    (9, 41),
    (9, 44),
    (9, 44),
    (9, 44),
    (9, 22),
    (9, 22),
    (9, 22),
    (9, 16),
    (9, 16),
    (9, 16),
    (9, 31),
    (9, 31),
    (9, 40),
    (9, 40),
    (9, 40),
    (9, 54),
    (9, 54),
    (9, 37),
    (9, 37),
    (9, 37),
    (9, 32),
    (9, 32),
    (9, 29),
    (9, 29),
    (9, 11),
    (9, 11),
    (9, 50),
    (9, 36),
    (9, 24),
    (9, 57),
    (9, 57),
    (9, 57),
    (9, 19),
    (9, 48),
    (9, 48),
    (9, 48),
    (9, 48),
    (9, 48),
    (9, 52),
    (9, 52),
    (9, 43),
    (9, 43),
    (9, 43),
    (9, 25),
    (9, 25),
    (9, 25),
    (9, 51),
    (9, 51),
    (9, 51),
    (9, 28),
    (9, 28),
    (9, 6),
    (9, 6),
    (9, 24),
    (9, 24),
    (9, 24),
    (9, 38),
    (9, 38),
    (9, 7),
    (9, 56),
    (9, 56),
    (9, 56),
    (9, 49),
    (9, 49),
    (9, 9),
    (9, 27),
    (9, 41),
    (9, 41),
    (9, 41),
    (9, 32),
    (9, 32),
    (9, 24),
    (9, 24),
    (9, 24);