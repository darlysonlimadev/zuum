require 'rails_helper'

RSpec.describe Corrida, type: :model do
  describe "validações" do
    let(:usuario) { Usuario.create!(nome: "Darlyson Lima", cpf: "60470204028", telefone: "88999990000") }

    it "é válida com endereço de partida, destino, valor estimado e usuário" do
      corrida = Corrida.new(
        endereco_partida: "Rua A",
        endereco_destino: "Rua B",
        valor_estimado: 150.75,
        usuario: usuario
      )
      expect(corrida).to be_valid
    end

    it "é inválida sem endereço de partida" do
      corrida = Corrida.new(
        endereco_partida: nil,
        endereco_destino: "Rua B",
        valor_estimado: 150.75,
        usuario: usuario
      )
      expect(corrida).not_to be_valid
      expect(corrida.errors[:endereco_partida]).to include("não pode ficar em branco")
    end

    it "é inválida sem endereço de destino" do
      corrida = Corrida.new(
        endereco_partida: "Rua A",
        endereco_destino: nil,
        valor_estimado: 150.75,
        usuario: usuario
      )
      expect(corrida).not_to be_valid
      expect(corrida.errors[:endereco_destino]).to include("não pode ficar em branco")
    end

    it "é inválida com valor estimado zerado ou negativo" do
      corrida = Corrida.new(
        endereco_partida: "Rua A",
        endereco_destino: "Rua B",
        valor_estimado: 0,
        usuario: usuario
      )
      expect(corrida).not_to be_valid
      expect(corrida.errors[:valor_estimado]).to include("deve ser maior que 0")
    end

    it "é inválida sem usuário associado" do
      corrida = Corrida.new(
        endereco_partida: "Rua A",
        endereco_destino: "Rua B",
        valor_estimado: 50.0,
        usuario: nil
      )
      expect(corrida).not_to be_valid
      expect(corrida.errors[:usuario]).to include("é obrigatório(a)")
    end
  end

  describe "escopos" do
    it "ordena por data de criação descendente no escopo :recent" do
      usuario = Usuario.create!(nome: "Darlyson Lima", cpf: "60470204028", telefone: "88999990000")
      mais_antiga = Corrida.create!(endereco_partida: "Rua A", endereco_destino: "Rua B", valor_estimado: 10.0, usuario: usuario, created_at: 1.day.ago)
      mais_recente = Corrida.create!(endereco_partida: "Rua C", endereco_destino: "Rua D", valor_estimado: 20.0, usuario: usuario, created_at: Time.current)

      expect(Corrida.recent).to eq([mais_recente, mais_antiga])
    end
  end
end
