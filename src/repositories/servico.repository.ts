import { Servico } from "../models/servico";
import { AppDataSource } from "../db/data-source";

class ServicoRepository {

    private servicoRepository = AppDataSource.getRepository(Servico);

    // Create (Salvar): Método save para criar e salvar um novo serviço.
    async save(servico: Servico): Promise<Servico> {
        try {
            console.log("Tentando salvar serviço:", servico);
            await this.servicoRepository.save(servico);
            console.log("Serviço salvo com sucesso:", servico);
            return servico;
        } catch (err) {
            console.error("Erro ao salvar serviço:", err);
            throw new Error("Falha ao criar o serviço!");
        }
    }

    // Read (Recuperar Todos): Método retrieveAll para recuperar todos os serviços.
    async retrieveAll(): Promise<Array<Servico>> {
        try {
            console.log("Recuperando todos os serviços");
            const servicos = await this.servicoRepository.find();
            console.log("Serviços recuperados:", servicos);
            return servicos;
        } catch (error) {
            console.error("Erro ao recuperar todos os serviços:", error);
            throw new Error("Falha ao retornar os serviços!");
        }
    }

    // Read (Recuperar por ID): Método retrieveById para recuperar um serviço específico pelo ID.
    async retrieveById(servicoId: number): Promise<Servico | null> {
        try {
            console.log("Recuperando serviço com ID:", servicoId);
            const servicoEncontrado = await this.servicoRepository.findOneBy({
                idServico: servicoId,
            });
            if (servicoEncontrado) {
                console.log("Serviço encontrado:", servicoEncontrado);
                return servicoEncontrado;
            }
            console.log("Serviço não encontrado com ID:", servicoId);
            return null;
        } catch (error) {
            console.error("Erro ao buscar o serviço:", error);
            throw new Error("Falha ao buscar o serviço!");
        }
    }

    // Update (Atualizar): Método update para atualizar um serviço existente.
    async update(servico: Servico): Promise<void> {
        try {
            console.log("Tentando atualizar serviço:", servico);
            await this.servicoRepository.save(servico);
            console.log("Serviço atualizado com sucesso:", servico);
        } catch (error) {
            console.error("Erro ao atualizar o serviço:", error);
            throw new Error("Falha ao atualizar o serviço!");
        }
    }

    // Delete (Deletar): Método delete para deletar um serviço pelo ID.
    async delete(servicoId: number): Promise<number> {
        try {
            console.log("Tentando deletar serviço com ID:", servicoId);
            const servicoEncontrado = await this.servicoRepository.findOneBy({
                idServico: servicoId,
            });
            if (servicoEncontrado) {
                await this.servicoRepository.remove(servicoEncontrado);
                console.log("Serviço deletado com sucesso:", servicoEncontrado);
                return 1;
            }
            console.log("Serviço não encontrado com ID:", servicoId);
            return 0;
        } catch (error) {
            console.error("Erro ao deletar o serviço:", error);
            throw new Error("Falha ao deletar o serviço!");
        }
    }
}

export default new ServicoRepository();