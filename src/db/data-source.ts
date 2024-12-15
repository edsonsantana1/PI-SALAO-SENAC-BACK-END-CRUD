import "reflect-metadata";
import { DataSource } from "typeorm";
import { Servico } from "../models/servico";

export const AppDataSource = new DataSource({
    type: "mysql",
    host: "localhost",
    port: 3306,
    username: "root",
    password: "edson273",
    database: "salaosenac",
    entities: [Servico], // Passe a classe da entidade aqui
    synchronize: false,
    logging: false,
});


