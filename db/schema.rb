# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_07_26_170242) do
  create_table "corridas", force: :cascade do |t|
    t.integer "usuario_id", null: false
    t.string "endereco_partida", null: false
    t.string "endereco_destino", null: false
    t.decimal "valor_estimado", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_id"], name: "index_corridas_on_usuario_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "nome", null: false
    t.string "cpf", null: false
    t.string "telefone", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cpf"], name: "index_usuarios_on_cpf", unique: true
  end

  add_foreign_key "corridas", "usuarios"
end
