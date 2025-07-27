# Sistema de Solicitações de Corrida

Sistema desenvolvido em Ruby on Rails para gerenciamento de solicitações de corrida.

## 🚀 Tecnologias Utilizadas

- **Ruby**: 3.3.8
- **Rails**: 8.0.2
- **Banco de Dados**: SQLite
- **Frontend**: ERB Templates + Semantic UI
- **Testes**: RSpec

## 📋 Funcionalidades

### Gestão de Usuários
- ✅ Cadastro de usuários com nome, CPF e telefone
- ✅ Edição de dados do usuário
- ✅ Exclusão de usuário
- ✅ Listagem de todos os usuários

### Gestão de Corridas
- ✅ Solicitação de nova corrida
- ✅ Associação da corrida com usuário
- ✅ Definição de endereços de origem e destino
- ✅ Valor estimado da corrida
- ✅ Visualização de detalhes da corrida
- ✅ Listagem de todas as corridas
- ✅ Filtro de corridas por usuário

### Interface
- ✅ Design responsivo com Semantic UI
- ✅ Navegação intuitiva
- ✅ Máscaras para CPF e telefone
- ✅ Mensagens de feedback
- ✅ Dashboard com estatísticas

## 🛠️ Instalação e Configuração

### Pré-requisitos

- Ruby 3.3.8
- Rails 8.0.2
- Git

1. **Clone o repositório**
```bash
git clone https://github.com/darlysonlimadev/zuum.git
cd zuum
```

2. **Instale as dependências**
```bash
bundle install
```

3. **Configure o banco de dados**
```bash
rails db:migrate
```

4. **Inicie o servidor**
```bash
rails server
```

5. **Acesse a aplicação**
```
http://localhost:3000
```