import express from "express";
import BookRoute from "./api/book/book.route";
import LibraryRoute from "./api/library/library.route";
import BorrowerRoute from "./api/borrower/borrower.route";
const cors = require("cors");
const morgan = require("morgan");

class App {
  private app: express.Application;
  private CLIENT_FOLDER = __dirname + "/../../client/library/dist/library";
  constructor() {
    this.app = express();
    this.app.use(express.json());
    this.app.use(express.urlencoded({ extended: false }));
    this.app.use(cors());
    this.app.use(morgan("dev"));
    this.registerEndpoints();
    this.serveAngular();
  }
  private registerEndpoints() {
    this.app.use("/api/book", BookRoute);
    this.app.use("/api/library", LibraryRoute);
    this.app.use("/api/borrower", BorrowerRoute);
  }

  public getApp() {
    return this.app;
  }

  public serveAngular() {
    this.app.use(express.static(this.CLIENT_FOLDER));
    this.app.get("/app/*", (req, res) => {
      res.sendFile("index.html", { root: this.CLIENT_FOLDER });
    });
  }
}

export default App;
