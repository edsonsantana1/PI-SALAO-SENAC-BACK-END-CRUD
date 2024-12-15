import { Request, Response } from "express";
import { Servico } from "../models/servico";
import servicoRepository from "../repositories/servico.repository";

export default class ServicoController {
    async save(req: Request, res: Response) {
        try {
            const servico: Servico = req.body;
            console.log("Tentando salvar serviço:", servico);
            const savedServico = await servicoRepository.save(servico);
            console.log("Serviço salvo com sucesso:", savedServico);
            res.status(201).send(savedServico);
        } catch (err) {
            console.error("Erro ao salvar serviço:", err);
            res.status(500).send({
                message: "Falha ao criar o serviço!"
            });
        }
    }

    async retrieveAll(req: Request, res: Response) {
        try {
            console.log("Recuperando todos os serviços");
            const servicos = await servicoRepository.retrieveAll();
            console.log("Serviços recuperados:", servicos);
            res.status(200).send(servicos);
        } catch (error) {
            console.error("Erro ao recuperar todos os serviços:", error);
            res.status(500).send({
                message: "Falha ao retornar os serviços!"
            });
        }
    }

    async retrieveById(req: Request, res: Response) {
        const servicoId = parseInt(req.params.id);
        try {
            console.log("Recuperando serviço com ID:", servicoId);
            const servicoEncontrado = await servicoRepository.retrieveById(servicoId);
            if (servicoEncontrado) {
                console.log("Serviço encontrado:", servicoEncontrado);
                res.status(200).send(servicoEncontrado);
            } else {
                console.log("Serviço não encontrado com ID:", servicoId);
                res.status(404).send({
                    message: "Serviço não encontrado!"
                });
            }
        } catch (error) {
            console.error("Erro ao buscar o serviço:", error);
            res.status(500).send({
                message: "Falha ao buscar o serviço!"
            });
        }
    }

    async update(req: Request, res: Response) {
        try {
            const servico: Servico = req.body;
            console.log("Tentando atualizar serviço:", servico);
            await servicoRepository.update(servico);
            console.log("Serviço atualizado com sucesso:", servico);
            res.status(200).send(servico);
        } catch (error) {
            console.error("Erro ao atualizar o serviço:", error);
            res.status(500).send({
                message: "Falha ao atualizar o serviço!"
            });
        }
    }

    async delete(req: Request, res: Response) {
        const servicoId = parseInt(req.params.id);
        try {
            console.log("Tentando deletar serviço com ID:", servicoId);
            const servicoEncontrado = await servicoRepository.retrieveById(servicoId);
            if (servicoEncontrado) {
                await servicoRepository.delete(servicoId);
                console.log("Serviço deletado com sucesso:", servicoEncontrado);
                res.status(200).send({
                    message: "Serviço deletado com sucesso!"
                });
            } else {
                console.log("Serviço não encontrado com ID:", servicoId);
                res.status(404).send({
                    message: "Serviço não encontrado!"
                });
            }
        } catch (error) {
            console.error("Erro ao deletar o serviço:", error);
            res.status(500).send({
                message: "Falha ao deletar o serviço!"
            });
        }
    }
}