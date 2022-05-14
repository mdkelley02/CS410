const books = require("./books.json");
let sql = "insert into books (title, author, publisher_id) values ";
books.forEach((book) => {
  const publisherId = Math.floor(Math.random() * 19) + 1;
  sql += `('${book.title}', '${book.author}', ${publisherId}), `;
});
sql = sql.substring(0, sql.length - 2);
sql += ";";
console.log(sql);
