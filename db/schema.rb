# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_13_013622) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "form_answers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.boolean "concordo_dados", null: false
    t.boolean "concordo_pesquisa", null: false
    t.binary "nome_ciphertext"
    t.binary "cpf_ciphertext"
    t.binary "responsavel_nome_ciphertext"
    t.binary "responsavel_cpf_ciphertext"
    t.binary "genero_ciphertext"
    t.binary "raca_ciphertext"
    t.binary "telefone_ciphertext"
    t.binary "endereco_rua_ciphertext"
    t.binary "endereco_numero_ciphertext"
    t.binary "endereco_complemento_ciphertext"
    t.binary "endereco_cep_ciphertext"
    t.binary "endereco_bairro_ciphertext"
    t.binary "endereco_cidade_ciphertext"
    t.binary "cadastro_digital_ciphertext"
    t.binary "cadastro_dificuldades_ciphertext"
    t.binary "cadastro_dias_ciphertext"
    t.binary "cadastro_tempo_ciphertext"
    t.binary "concorda_acordo_valores_ciphertext"
    t.binary "concorda_acordo_comentario"
    t.binary "pagamento_realizado_ciphertext"
    t.binary "denuncia_telefone_numero_ciphertext"
    t.binary "denuncia_telefone_resposta_ciphertext"
    t.binary "denuncia_telefone_comentario_ciphertext"
    t.binary "denuncia_presencial_numero_ciphertext"
    t.binary "denuncia_presencial_resposta_ciphertext"
    t.binary "denuncia_presencial_comentario_ciphertext"
    t.binary "denuncia_mpe_numero_ciphertext"
    t.binary "denuncia_mpe_resposta_ciphertext"
    t.binary "denuncia_mpe_comentario_ciphertext"
    t.binary "denuncia_dp_numero_ciphertext"
    t.binary "denuncia_dp_resposta_ciphertext"
    t.binary "denuncia_dp_comentario_ciphertext"
    t.binary "denuncia_outros_ciphertext"
    t.binary "concorda_acordo_trecho_ciphertext"
    t.binary "covid_grupo_risco_ciphertext"
    t.binary "covid_sintomas_ciphertext"
    t.binary "covid_atencao_medica_ciphertext"
    t.binary "covid_testado_ciphertext"
    t.binary "covid_resultado_ciphertext"
    t.binary "duvidas_reclamacoes_sugestoes_ciphertext"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.boolean "admin", default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
