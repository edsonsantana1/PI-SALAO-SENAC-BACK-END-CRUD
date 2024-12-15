import express, { Application } from "express";
import Server from "./index"; // Certifique-se de que o caminho está correto

const app: Application = express();
const server: Server = new Server(app);
const PORT: number = 8080;

app.listen(PORT, "localhost", function () {
    console.log(`Server is running on port ${PORT}`);
    
}).on("error", (err: any) => {
    if (err.code === "EADDRINUSE") {
        console.log("Error: address is already in use");
    } else {
        console.error(err);
    }
});