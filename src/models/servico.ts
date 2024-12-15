import { Entity, PrimaryGeneratedColumn, Column, ManyToMany } from "typeorm";

@Entity({ name: "Servico" })
export class Servico {
    @PrimaryGeneratedColumn()
    idServico!: number;

    @Column({ length: 60, nullable: false }) 
    nome: string;

    @Column("decimal", { precision: 7, scale: 2 })
    valor: number;

    constructor(nome: string, valor: number) {
        this.nome = nome;
        this.valor = valor;
    }
}




