-- create database ==================================
DROP DATABASE IF EXISTS library;

CREATE DATABASE IF NOT EXISTS library;

use library;

-- create schema ==================================
SET
    FOREIGN_KEY_CHECKS = 0;

SET
    UNIQUE_CHECKS = 0;

DROP TABLE IF EXISTS book;

CREATE TABLE IF NOT EXISTS book (
    book_id INT AUTO_INCREMENT NOT NULL,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    publisher_id INT NOT NULL,
    PRIMARY KEY (book_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

DROP TABLE IF EXISTS publisher;

CREATE TABLE IF NOT EXISTS publisher (
    publisher_id INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (publisher_id)
);

DROP TABLE IF EXISTS borrower;

CREATE TABLE IF NOT EXISTS borrower (
    borrower_id INT AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (borrower_id)
);

DROP TABLE IF EXISTS library_branch;

CREATE TABLE IF NOT EXISTS library_branch (
    library_branch_id INT AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (library_branch_id)
);

DROP TABLE IF EXISTS library_branch_book_copy;

CREATE TABLE IF NOT EXISTS library_branch_book_copy (
    book_copy_id INT AUTO_INCREMENT,
    library_branch_id INT NOT NULL,
    book_id INT NOT NULL,
    PRIMARY KEY (book_copy_id),
    FOREIGN KEY (library_branch_id) REFERENCES library_branch(library_branch_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

DROP TABLE IF EXISTS library_branch_book_loan;

CREATE TABLE IF NOT EXISTS library_branch_book_loan (
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

-- update the due date value for recently inserted loan
DELIMITER $ $ CREATE TRIGGER after_library_branch_book_loan_insert
AFTER
INSERT
    ON library_branch_book_loan FOR EACH ROW BEGIN
UPDATE
    library_branch_book_loan
SET
    due_date = DATE_ADD(loan_date, INTERVAL 14 DAY)
WHERE
    loan_id = NEW.loan_id;

END $ $ DELIMITER;

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
    ('Harry Johnson');

-- seed library_branch
INSERT INTO
    library_branch (name)
VALUES
    ('Boise Library'),
    ('Caldwell Library'),
    ('Meridian Library'),
    ('Star Library'),
    ('Eagle Library');

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
    ('Njál''s Saga', 'Unknown', 13),
    ('Pride and Prejudice', 'Jane Austen', 16),
    ('Le Père Goriot', 'Honoré de Balzac', 5),
    (
        'Molloy, Malone Dies, The Unnamable, the trilogy',
        'Samuel Beckett',
        16
    ),
    ('The Decameron', 'Giovanni Boccaccio', 13),
    ('Ficciones', 'Jorge Luis Borges', 10),
    ('Wuthering Heights', 'Emily Brontë', 1),
    ('The Stranger', 'Albert Camus', 3),
    ('Poems', 'Paul Celan', 4),
    (
        'Journey to the End of the Night',
        'Louis-Ferdinand Céline',
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
    ('Berlin Alexanderplatz', 'Alfred Döblin', 13),
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
    ('Gypsy Ballads', 'Federico García Lorca', 4),
    (
        'One Hundred Years of Solitude',
        'Gabriel García Márquez',
        18
    ),
    (
        'Love in the Time of Cholera',
        'Gabriel García Márquez',
        14
    ),
    ('Faust', 'Johann Wolfgang von Goethe', 2),
    ('Dead Souls', 'Nikolai Gogol', 13),
    ('The Tin Drum', 'Günter Grass', 11),
    (
        'The Devil to Pay in the Backlands',
        'João Guimarães Rosa',
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
    ('The recognition of Shakuntala', 'Kālidāsa', 13),
    (
        'The Sound of the Mountain',
        'Yasunari Kawabata',
        14
    ),
    ('Zorba the Greek', 'Nikos Kazantzakis', 15),
    ('Sons and Lovers', 'D. H. Lawrence', 6),
    ('Independent People', 'Halldór Laxness', 6),
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
        'François Rabelais',
        3
    ),
    ('Pedro Páramo', 'Juan Rulfo', 19),
    ('The Masnavi', 'Rumi', 10),
    ('Midnight''s Children', 'Salman Rushdie', 10),
    ('Bostan', 'Saadi', 4),
    (
        'Season of Migration to the North',
        'Tayeb Salih',
        11
    ),
    ('Blindness', 'José Saramago', 3),
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