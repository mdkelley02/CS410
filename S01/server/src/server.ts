import "dotenv/config";
import App from "./app";
import { Route } from "./models";
import { createBook, createLibraryBranchBookCopy } from "./routes";
import { config } from "./config";

const routes: Route[] = [createBook, createLibraryBranchBookCopy];

const app = new App(routes).getApp();

app.listen(process.env.PORT, () => {
  console.log(`Server is running on port ${config.port}`);
});
