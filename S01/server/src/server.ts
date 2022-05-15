import App from "./app";
import { config } from "./config";

const app = new App().getApp();

app.listen(process.env.PORT, () => {
  console.log(`Server is running on port ${config.port}`);
});
