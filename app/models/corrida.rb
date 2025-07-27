class Corrida < ApplicationRecord
  belongs_to :usuario
  validates :endereco_partida, :endereco_destino, presence: true
  validates :valor_estimado, presence: true, numericality: {
    greater_than: 0,
    less_than: 100_000
  }

  scope :recent, -> { order(created_at: :desc) }
end
