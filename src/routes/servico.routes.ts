import { Router } from "express";
import ServicoController from "../controllers/servico.controller";

class ServicoRoutes {
    public router: Router;
    private controller: ServicoController;

    constructor() {
        this.router = Router();
        this.controller = new ServicoController();
        this.initializeRoutes();
    }

    private initializeRoutes() {
        // Criar um novo serviço.
        this.router.post("/servico", this.controller.save.bind(this.controller));

        // Retornar todos os serviços.
        this.router.get("/servicos", this.controller.retrieveAll.bind(this.controller));

        // Retornar um serviço específico pelo ID.
        this.router.get("/servicos/:id", this.controller.retrieveById.bind(this.controller));

        // Atualizar um serviço existente.
        this.router.put("/servicos/:id", this.controller.update.bind(this.controller));

        // Deletar um serviço pelo ID.
        this.router.delete("/servicos/:id", this.controller.delete.bind(this.controller));
    }
}

export default new ServicoRoutes().router;