class CreateUsuarios < ActiveRecord::Migration[8.0]
  def change
    create_table :usuarios do |t|
      t.string :nome, null: false
      t.string :cpf, null: false
      t.string :telefone, null: false

      t.timestamps
    end
    add_index :usuarios, :cpf, unique: true
  end
end
