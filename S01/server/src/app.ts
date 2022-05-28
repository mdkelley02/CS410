import express from "express";
import BookRoute from "./api/book/book.route";
import LibraryRoute from "./api/library/library.route";
import BorrowerRoute from "./api/borrower/borrower.route";
const cors = require("cors");
const morgan = require("morgan");

const CLIENT_DIST_DIR = __dirname + "/../../client/library/dist/library";

class App {
  private app: express.Application;

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
    this.app.use(express.static(CLIENT_DIST_DIR));
    this.app.get("/app/*", (req, res) => {
      res.sendFile("index.html", { root: CLIENT_DIST_DIR });
    });
  }
}

export default App;
