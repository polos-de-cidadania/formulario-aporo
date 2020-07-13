# frozen_string_literal: true

class FormAnswer < ApplicationRecord
  extend Enumerize

  attribute :concordo_dados, :boolean
  attribute :concordo_pesquisa, :boolean
  encrypts :nome
  encrypts :cpf
  encrypts :responsavel_nome
  encrypts :responsavel_cpf
  encrypts :telefone
  encrypts :genero
  encrypts :raca
  encrypts :endereco_rua
  encrypts :endereco_numero
  encrypts :endereco_complemento
  encrypts :endereco_cep
  encrypts :endereco_bairro
  encrypts :endereco_cidade

  encrypts :cadastro_digital
  encrypts :cadastro_dificuldades
  encrypts :cadastro_dias, type: :integer
  encrypts :cadastro_tempo, type: :integer
  encrypts :concorda_acordo_valores
  encrypts :pagamento_realizado, type: :boolean

  encrypts :denuncia_telefone_numero, type: :integer
  encrypts :denuncia_telefone_resposta
  encrypts :denuncia_telefone_comentario
  encrypts :denuncia_presencial_numero, type: :integer
  encrypts :denuncia_presencial_resposta
  encrypts :denuncia_presencial_comentario
  encrypts :denuncia_mpe_numero, type: :integer
  encrypts :denuncia_mpe_resposta
  encrypts :denuncia_mpe_comentario
  encrypts :denuncia_dp_numero, type: :integer
  encrypts :denuncia_dp_resposta
  encrypts :denuncia_dp_comentario
  encrypts :denuncia_outros

  encrypts :concorda_acordo_trecho, type: :integer

  encrypts :covid_sintomas, type: :boolean
  encrypts :covid_testado, type: :boolean
  encrypts :covid_testes_publica, type: :integer
  encrypts :covid_testes_privada, type: :integer
  encrypts :covid_resultado
  encrypts :covid_atencao_medica
  encrypts :duvidas_reclamacoes_sugestoes

  enumerize :genero, in: %i[masculino feminino outro nao_declarado]
  enumerize :raca, in: %i[branco preto pardo indigena asiatico outro nao_declarado]
  enumerize :cadastro_digital, in: %i[sim nao acesso]
  DENUNCIA_RESPOSTA = %i[nao insatisfatorio regular bom otimo].freeze
  enumerize :denuncia_telefone_resposta, in: DENUNCIA_RESPOSTA
  enumerize :denuncia_presencial_resposta, in: DENUNCIA_RESPOSTA
  enumerize :denuncia_mpe_resposta, in: DENUNCIA_RESPOSTA
  enumerize :denuncia_dp_resposta, in: DENUNCIA_RESPOSTA
  enumerize :covid_resultado, in: %i[positivo negativo inconclusivo]
  enumerize :covid_atencao_medica, in: %i[rede_publica rede_privada nao]

  validates :concordo_dados, :concordo_pesquisa, acceptance: true
  validates :nome, :cpf, :telefone, :genero, :raca,
            :endereco_rua, :endereco_numero, :endereco_complemento, :endereco_cep, :endereco_bairro, :endereco_cidade,
            :cadastro_digital, :cadastro_dificuldades,
            :concorda_acordo_valores, :pagamento_realizado,
            :covid_sintomas, :covid_testado,
            presence: true
  validates :cadastro_dias,
            numericality: { only_integer: true, allow_nil: true,
                            greater_than: 0 }
  validates :cadastro_tempo,
            numericality: { only_integer: true, allow_nil: true,
                            less_than_or_equal_to: 10,
                            greater_than_or_equal_to: 1 }
  validates :denuncia_telefone_numero,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :denuncia_telefone_resposta, presence: true, if: -> { denuncia_telefone_numero.positive? }
  validates :denuncia_presencial_numero,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :denuncia_presencial_resposta, presence: true, if: -> { denuncia_presencial_numero.positive? }
  validates :denuncia_mpe_numero,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :denuncia_mpe_resposta, presence: true, if: -> { denuncia_mpe_numero.positive? }
  validates :denuncia_dp_numero,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :denuncia_dp_resposta, presence: true, if: -> { denuncia_dp_numero.positive? }
  validates :concorda_acordo_trecho,
            numericality: { only_integer: true,
                            less_than_or_equal_to: 5,
                            greater_than_or_equal_to: 1 }
  validates :covid_testes_publica,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 },
            if: -> { covid_testado }
  validates :covid_testes_privada,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 },
            if: -> { covid_testado }
end
