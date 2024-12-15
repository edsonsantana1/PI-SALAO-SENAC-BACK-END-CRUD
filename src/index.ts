import express, { Application } from "express";
import cors, { CorsOptions } from "cors";
import { AppDataSource } from "./db/data-source";
import Routes from "./routes/routes"; // Importe as rotas

class Server {
    constructor(app: Application) {
        this.config(app);
        new Routes(app);
    }

    private config(app: Application): void {
        const corsOptions: CorsOptions = {
            origin: "http://localhost:8081"
        };
        app.use(cors(corsOptions));
        app.use(express.json());
        app.use(express.urlencoded({ extended: true }));
    }
}

export default Server; // Certifique-se de exportar a classe Server como padrão

const main = async () => {
    await AppDataSource.initialize();
    console.log("Data Source has been initialized!");

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
};

main().catch((err) => {
    console.error("Error during Data Source initialization:", err);
});