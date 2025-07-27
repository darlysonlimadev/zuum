require 'rails_helper'

RSpec.describe "Usuarios", type: :request do
  let(:usuario) do
    Usuario.create!(nome: "Darlyson Lima", cpf: "60470204028", telefone: "88999990000")
  end

  describe "GET /usuarios" do
    it "retorna sucesso (200 OK)" do
      get usuarios_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /usuarios/:id" do
    it "mostra um usuário específico" do
      get usuario_path(usuario)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(usuario.nome)
    end
  end

  describe "POST /usuarios" do
    it "cria um novo usuário com dados válidos" do
      expect {
        post usuarios_path, params: {
          usuario: {
            nome: "Raquel",
            cpf: "87142688092",
            telefone: "88988887777"
          }
        }
      }.to change(Usuario, :count).by(1)

      usuario = Usuario.last
      expect(response).to redirect_to(usuario_path(usuario))
      follow_redirect!
      expect(response.body).to include("Usuário cadastrado com sucesso")
    end

    it "não cria usuário com dados inválidos" do
      expect {
        post usuarios_path, params: {
          usuario: {
            nome: "",
            cpf: "11111111111", # inválido
            telefone: ""
          }
        }
      }.not_to change(Usuario, :count)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("inválido").or include("não pode ficar em branco")
    end
  end

  describe "PATCH /usuarios/:id" do
    it "atualiza os dados do usuário com sucesso" do
      patch usuario_path(usuario), params: {
        usuario: {
          nome: "Darlyson Cavalcante"
        }
      }

      expect(response).to redirect_to(usuario_path(usuario))
      follow_redirect!
      expect(response.body).to include("Usuário atualizado com sucesso")
      expect(usuario.reload.nome).to eq("Darlyson Cavalcante")
    end

    it "não atualiza com dados inválidos" do
      patch usuario_path(usuario), params: {
        usuario: {
          cpf: "11111111111" # CPF inválido
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(usuario.reload.cpf).to eq("60470204028") # permanece original
    end
  end

  describe "DELETE /usuarios/:id" do
    it "exclui o usuário" do
      usuario_para_excluir = Usuario.create!(nome: "Carlos", cpf: "42615231081", telefone: "88888888888")

      expect {
        delete usuario_path(usuario_para_excluir)
      }.to change(Usuario, :count).by(-1)

      expect(response).to redirect_to(usuarios_path)
    end
  end
end
