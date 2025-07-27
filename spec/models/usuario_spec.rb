require 'rails_helper'

RSpec.describe Usuario, type: :model do
  describe "validações" do
    let(:nome_valido) { "Darlyson Lima" }
    let(:cpf_valido_formatado) { "604.702.040-28" }
    let(:cpf_valido_limpo)     { "60470204028" }
    let(:telefone_formatado)   { "(88) 99999-0000" }
    let(:telefone_limpo)       { "88999990000" }

    it "é válido com nome, telefone e cpf válidos" do
      usuario = Usuario.new(nome: nome_valido, cpf: cpf_valido_formatado, telefone: telefone_formatado)
      expect(usuario).to be_valid
    end

    it "é inválido sem nome" do
      usuario = Usuario.new(nome: nil, cpf: cpf_valido_formatado, telefone: telefone_limpo)
      expect(usuario).not_to be_valid
      expect(usuario.errors[:nome]).to include("não pode ficar em branco")
    end

    it "é inválido com CPF duplicado" do
      Usuario.create!(nome: "Maria", cpf: cpf_valido_limpo, telefone: telefone_limpo)
      usuario = Usuario.new(nome: nome_valido, cpf: cpf_valido_formatado, telefone: telefone_limpo)
      expect(usuario).not_to be_valid
      expect(usuario.errors[:cpf]).to include("já está em uso")
    end

    it "é inválido com CPF inválido" do
      usuario = Usuario.new(nome: nome_valido, cpf: "11111111111", telefone: telefone_limpo)
      expect(usuario).not_to be_valid
      expect(usuario.errors[:cpf]).to include("inválido")
    end

    it "é inválido com telefone com menos de 10 dígitos" do
      usuario = Usuario.new(nome: nome_valido, cpf: "87142688092", telefone: "889999000")
      expect(usuario).not_to be_valid
      expect(usuario.errors[:telefone]).to include("deve ter 10 ou 11 dígitos")
    end

    it "é inválido com telefone com mais de 11 dígitos" do
      usuario = Usuario.new(nome: nome_valido, cpf: "13489765041", telefone: "889999900001")
      expect(usuario).not_to be_valid
      expect(usuario.errors[:telefone]).to include("deve ter 10 ou 11 dígitos")
    end
  end

  describe "callbacks" do
    let(:usuario) { Usuario.new(nome: "Darlyson Lima", cpf: "604.702.040-28", telefone: "(88) 99999-0000") }

    it "remove máscara do CPF e telefone antes da validação" do
      usuario.valid?

      expect(usuario.cpf).to eq("60470204028")
      expect(usuario.telefone).to eq("88999990000")
    end
  end
end
