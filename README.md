# Projeto PI - Salão SENAC

Este projeto é um sistema CRUD para gerenciar os serviços de um salão de beleza, desenvolvido com TypeScript. O sistema inclui funcionalidades para criar, ler, atualizar e deletar serviços, além de gerenciar rotas e controladores.

## Tecnologias Utilizadas

- **TypeScript**: Linguagem de programação que adiciona tipagem estática ao JavaScript.
- **Express**: Framework web para Node.js.
- **MySQL**: Banco de dados relacional.
- **TypeORM**: ORM para Node.js, utilizado para interagir com o banco de dados MySQL.

## Estrutura do Projeto

ProjetoPI/
├── src/
│   ├── controllers/
│   │   └── serviceController.ts
│   ├── entities/
│   │   └── service.ts
│   ├── routes/
│   │   └── serviceRoutes.ts
│   ├── config/
│   │   └── database.ts
│   ├── app.ts
│   └── server.ts
├── package.json
├── tsconfig.json
└── README.md

## Como Executar
Clone o repositório.
Instale as dependências com npm install.
Configure o banco de dados em src/config/database.ts.
Execute o servidor com npm start.

##Autor
Edson de Santana Alves - edsonsantana1

