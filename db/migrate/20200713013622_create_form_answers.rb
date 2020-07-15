# frozen_string_literal: true

class CreateFormAnswers < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto'
    create_table :form_answers, id: :uuid do |t| # rubocop:disable Metrics/BlockLength
      t.boolean :concordo_dados, null: false
      t.boolean :concordo_pesquisa, null: false

      t.binary :nome_ciphertext
      t.binary :cpf_ciphertext
      t.binary :responsavel_nome_ciphertext
      t.binary :responsavel_cpf_ciphertext
      t.binary :genero_ciphertext
      t.binary :raca_ciphertext
      t.binary :telefone_ciphertext
      t.binary :endereco_rua_ciphertext
      t.binary :endereco_numero_ciphertext
      t.binary :endereco_complemento_ciphertext
      t.binary :endereco_cep_ciphertext
      t.binary :endereco_bairro_ciphertext
      t.binary :endereco_cidade_ciphertext

      t.binary :cadastro_digital_ciphertext
      t.binary :cadastro_dificuldades_ciphertext
      t.binary :cadastro_dias_ciphertext
      t.binary :cadastro_tempo_ciphertext
      t.binary :concorda_acordo_valores_ciphertext
      t.binary :concorda_acordo_comentario_ciphertext
      t.binary :pagamento_realizado_ciphertext

      t.binary :denuncia_telefone_numero_ciphertext
      t.binary :denuncia_telefone_resposta_ciphertext
      t.binary :denuncia_telefone_comentario_ciphertext
      t.binary :denuncia_presencial_numero_ciphertext
      t.binary :denuncia_presencial_resposta_ciphertext
      t.binary :denuncia_presencial_comentario_ciphertext
      t.binary :denuncia_mpe_numero_ciphertext
      t.binary :denuncia_mpe_resposta_ciphertext
      t.binary :denuncia_mpe_comentario_ciphertext
      t.binary :denuncia_dp_numero_ciphertext
      t.binary :denuncia_dp_resposta_ciphertext
      t.binary :denuncia_dp_comentario_ciphertext
      t.binary :denuncia_outros_ciphertext

      t.binary :concorda_acordo_trecho_ciphertext

      t.binary :covid_grupo_risco_ciphertext
      t.binary :covid_sintomas_ciphertext
      t.binary :covid_atencao_medica_ciphertext
      t.binary :covid_testado_ciphertext
      t.binary :covid_resultado_ciphertext
      t.binary :duvidas_reclamacoes_sugestoes_ciphertext

      t.timestamps
    end
  end
end
