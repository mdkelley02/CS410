import express from "express";
import { Route } from "./models";
import { conn } from "./database";

class App {
  private app: express.Application;

  constructor(routes: Route[]) {
    this.app = express();
    this.app.use(express.json());
    this.app.use(express.urlencoded({ extended: false }));
    this.registerRoutes(routes);
  }

  private registerRoutes(routes: Route[]) {
    routes.forEach((route) => {
      switch (route.method) {
        case "GET":
          this.app.get(route.path, route.handler);
          break;
        case "POST":
          this.app.post(route.path, route.handler);
          break;
        default:
          break;
      }
    });
  }

  public getApp() {
    return this.app;
  }
}

export default App;
