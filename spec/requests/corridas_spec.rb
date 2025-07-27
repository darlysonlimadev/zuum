require 'rails_helper'

RSpec.describe "Corridas", type: :request do
  let(:usuario) do
    Usuario.create!(nome: "Darlyson Lima", cpf: "60470204028", telefone: "88999990000")
  end

  let(:corrida) do
    Corrida.create!(
      usuario: usuario,
      endereco_partida: "Rua A",
      endereco_destino: "Rua B",
      valor_estimado: 25.50
    )
  end

  describe "GET /corridas" do
    it "retorna sucesso (200 OK)" do
      get corridas_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /corridas" do
    it "cria uma corrida válida" do
      expect {
        post corridas_path, params: {
          corrida: {
            usuario_id: usuario.id,
            endereco_partida: "Rua 1",
            endereco_destino: "Rua 2",
            valor_estimado: 50.0
          }
        }
      }.to change(Corrida, :count).by(1)

      corrida = Corrida.last
      expect(response).to redirect_to(corrida_path(corrida))
      follow_redirect!
      expect(response.body).to include("Corrida cadastrada com sucesso")
    end

    it "não cria corrida com dados inválidos" do
      expect {
        post corridas_path, params: {
          corrida: {
            usuario_id: nil,
            endereco_partida: "",
            endereco_destino: "",
            valor_estimado: 0
          }
        }
      }.not_to change(Corrida, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PATCH /corridas/:id" do
    it "atualiza uma corrida com dados válidos" do
      patch corrida_path(corrida), params: {
        corrida: {
          endereco_partida: "Nova Rua A",
          valor_estimado: 99.99
        }
      }

      expect(response).to redirect_to(corrida_path(corrida))
      follow_redirect!
      expect(response.body).to include("Corrida atualizada com sucesso")
      expect(corrida.reload.endereco_partida).to eq("Nova Rua A")
      expect(corrida.valor_estimado).to eq(99.99)
    end

    it "não atualiza com dados inválidos" do
      patch corrida_path(corrida), params: {
        corrida: {
          valor_estimado: -5
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(corrida.reload.valor_estimado).not_to eq(-5)
    end
  end

  describe "DELETE /corridas/:id" do
    it "exclui a corrida" do
      corrida_para_excluir = Corrida.create!(
        usuario: usuario,
        endereco_partida: "Rua X",
        endereco_destino: "Rua Y",
        valor_estimado: 15.0
      )

      expect {
        delete corrida_path(corrida_para_excluir)
      }.to change(Corrida, :count).by(-1)

      expect(response).to redirect_to(corridas_path)
    end
  end

  describe "GET /corridas/filtrar_usuario" do
    it "filtra corridas por usuário quando id é válido" do
      get filtrar_usuario_corridas_path, params: { usuario_id: usuario.id }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(usuario.nome)
    end

    it "redireciona quando usuario_id está ausente" do
      get filtrar_usuario_corridas_path

      expect(response).to redirect_to(corridas_path)
      follow_redirect!
      expect(response.body).to include("Selecione um usuário para visualizar suas corridas.")
    end

    it "redireciona se usuário não existir" do
      get filtrar_usuario_corridas_path, params: { usuario_id: 999999 }

      expect(response).to redirect_to(corridas_path)
      follow_redirect!
      expect(response.body).to include("Usuário não encontrado.")
    end
  end
end
