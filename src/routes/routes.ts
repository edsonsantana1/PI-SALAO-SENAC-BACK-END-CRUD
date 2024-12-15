import { Application } from "express";
import servicoRoutes from "./servico.routes"; // Importe as rotas de serviços

// Concentrador de rotas
export default class Routes {
    constructor(app: Application) {
        app.use("/salaosenac", servicoRoutes); // Adicione as rotas de serviços
    }
}