# Projeto de Gerenciamento de Tarefas

Este projeto consiste em uma API GraphQL desenvolvida em Elixir/Phoenix e um frontend em React para gerenciamento de tarefas.

## Backend (Elixir/Phoenix)

### Pré-requisitos

- Elixir 1.14.0 ou superior
- Phoenix 1.5.7 ou superior
- Docker e Docker Compose
- PostgreSQL (via Docker)

### Configuração do Ambiente

1. Clone o repositório:
```bash
git clone https://github.com/lbgrandolpho/btime-test
cd btime-test
```

2. Inicie o banco de dados PostgreSQL via Docker:
```bash
cd backend
docker compose up db -d
```

3. Ainda dentro da pasta `backend`, configure o banco de dados:
```bash
mix deps.get
mix ecto.create
mix ecto.migrate
```

4. Popule o banco de dados com dados de exemplo:
```bash
mix run priv/repo/seeds.exs
```

5. Inicie o servidor:
```bash
mix phx.server
```

O servidor estará rodando em `http://localhost:4000`.

### Estrutura das Entidades

#### Task Schema
```elixir
schema "tasks" do
  field :name, :string
  field :description, :string
  field :execution_date, :date
  field :location, :string
  field :priority, :string
  has_many :attachments, Backend.Model.Attachment
  timestamps()
end
```

#### Attachment Schema
```elixir
schema "attachments" do
  field :url, :string
  belongs_to :task, Backend.Model.Task
  timestamps()
end
```

### API GraphQL

#### Queries Disponíveis

1. Listar Tarefas
```graphql
query {
  tasks(
    name: String
    description: String
    execution_date: Date
    priority: String
    location: String
  ) {
    id
    name
    description
    execution_date
    location
    priority
    attachments {
      id
      url
    }
  }
}
```

2. Buscar Tarefa Específica
```graphql
query {
  task(id: ID!) {
    id
    name
    description
    execution_date
    location
    priority
    attachments {
      id
      url
      identifier
    }
  }
}
```

### Decisões Técnicas (Backend)

- Utilização do Absinthe para implementação do GraphQL
- Implementação de busca exata por nome e busca parcial por descrição
- Filtros implementados usando Ecto.Query
- Validações no banco de dados e changesets para garantir integridade dos dados

## Frontend (React)

### Pré-requisitos

- Node.js 14 ou superior
- npm ou yarn

### Configuração do Ambiente

1. Instalar dependências:
```bash
cd frontend
npm install
```

2. Iniciar o servidor de desenvolvimento:
```bash
npm start
```

O frontend estará rodando em `http://localhost:3000`.

### Estrutura de Pastas (arquivos principais)

```
frontend/
├── src/
│   ├── components/
│   │   ├── TaskCard.js
│   │   ├── TaskList.js
│   │   └── TaskModal.js
│   ├── apolloClient.js
│   ├── App.js
│   └── index.js
└── package.json
```

### Bibliotecas Utilizadas

- `@apollo/client`: Cliente GraphQL para consumo da API
- `styled-components`: Estilização dos componentes

### Decisões Técnicas (Frontend)

- Utilização do Apollo Client para gerenciamento de estado e cache
- Implementação de filtros em tempo real
- Componentes React funcionais com hooks
- Estilização modular com styled-components
- Busca ativada por tecla Enter para otimização de requisições

## Funcionalidades Principais

- Visualização de tarefas em formato kanban
- Busca textual por nome (exata) e descrição (parcial)
- Filtros por:
  - Data de execução
  - Prioridade
  - Local de execução
- Modal com detalhes da tarefa e arquivos anexos
- Paginação para controle de carga de dados

## Desenvolvimento

### Considerações sobre CORS

O backend está configurado para aceitar requisições do frontend em desenvolvimento (localhost:3000). Se necessário, ajuste as configurações de CORS no arquivo `backend/lib/backend_web/endpoint.ex`.

### Ambiente de Teste

Para executar os testes do backend:
```bash
cd backend
mix test
```

Para o frontend:
```bash
cd frontend
npm test
```
