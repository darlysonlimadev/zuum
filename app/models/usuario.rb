class Usuario < ApplicationRecord
  has_many :corridas, dependent: :destroy

  validates :nome, :cpf, :telefone, presence: true
  validates :cpf, uniqueness: true
  validates :telefone, format: { with: /\A\d{10,11}\z/, message: "deve ter 10 ou 11 dígitos" }

  before_validation :remover_mascara
  validate :cpf_valido

  private

  def remover_mascara
    self.cpf = cpf.to_s.gsub(/\D/, '')
    self.telefone = telefone.to_s.gsub(/\D/, '')
  end

  def cpf_valido
    unless CPF.valid?(cpf)
      errors.add(:cpf, "inválido")
    end
  end
end
