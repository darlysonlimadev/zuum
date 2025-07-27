class CreateCorridas < ActiveRecord::Migration[8.0]
  def change
    create_table :corridas do |t|
      t.references :usuario, null: false, foreign_key: true
      t.string :endereco_partida, null: false
      t.string :endereco_destino, null: false
      t.datetime :horario_solicitacao, null: false
      t.decimal :valor_estimado, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
