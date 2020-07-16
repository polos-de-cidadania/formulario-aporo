# frozen_string_literal: true

class FormAnswer < ApplicationRecord # rubocop:disable Metrics/ClassLength
  attr_accessor :page

  before_validation :set_form_page
  after_validation :update_form_page
  validate :last_form_page

  attribute :concordo_dados, :boolean
  attribute :concordo_pesquisa, :boolean

  encrypts :nome
  encrypts :cpf
  encrypts :responsavel_nome
  encrypts :responsavel_cpf
  encrypts :genero
  encrypts :raca
  encrypts :telefone
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
  encrypts :concorda_acordo_comentario
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

  encrypts :covid_grupo_risco
  encrypts :covid_sintomas, type: :boolean
  encrypts :covid_atencao_medica
  encrypts :covid_testado
  encrypts :covid_resultado
  encrypts :duvidas_reclamacoes_sugestoes

  with_options if: -> { page >= 0 } do
    validates :concordo_dados, :concordo_pesquisa, acceptance: true
  end

  with_options if: -> { page >= 1 } do
    validates :nome,
              :endereco_rua, :endereco_numero, :endereco_cep, :endereco_bairro, :endereco_cidade,
              presence: true
    validates :cpf, :responsavel_cpf,
              length: { is: 11, allow_blank: true }
    validates :cpf,
              presence: true, if: -> { page >= 1 && responsavel_cpf.blank? }
    validates :responsavel_cpf,
              presence: true, if: -> { page >= 1 && responsavel_nome? }
    validates :genero,
              inclusion: { in: %w[masculino feminino outro nao_declarado] }
    validates :raca,
              inclusion: { in: %w[branco preto pardo indigena asiatico outro nao_declarado] }
    validates :telefone,
              format: { with: /\A\d{2}9?\d{8}\z/, allow_blank: true }
    validates :endereco_cep,
              length: { is: 8 }
  end

  with_options if: -> { page >= 2 } do
    validates :cadastro_digital,
              inclusion: { in: %w[sim nao apenas_acesso] }
    validates :cadastro_dificuldades, :concorda_acordo_valores,
              inclusion: { in: %w[sim parcialmente nao] }
    validates :cadastro_dias,
              numericality: { only_integer: true,
                              greater_than: 0 },
              if: -> { page >= 2 && cadastro_digital == 'sim' }
    validates :cadastro_tempo,
              numericality: { only_integer: true,
                              less_than_or_equal_to: 10,
                              greater_than_or_equal_to: 1 },
              if: -> { page >= 2 && cadastro_digital == 'sim' }
    validates :pagamento_realizado,
              inclusion: { in: [true, false] }

    before_validation do
      next if cadastro_digital == 'sim'

      self.cadastro_dias  = nil
      self.cadastro_tempo = nil
    end
  end

  with_options if: -> { page >= 3 } do
    validates :denuncia_telefone_numero,
              numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :denuncia_telefone_resposta,
              presence: true, if: -> { page >= 3 && denuncia_telefone_numero&.positive? }
    validates :denuncia_presencial_numero,
              numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :denuncia_presencial_resposta,
              presence: true, if: -> { page >= 3 && denuncia_presencial_numero&.positive? }
    validates :denuncia_mpe_numero,
              numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :denuncia_mpe_resposta,
              presence: true, if: -> { page >= 3 && denuncia_mpe_numero&.positive? }
    validates :denuncia_dp_numero,
              numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :denuncia_dp_resposta,
              presence: true, if: -> { page >= 3 && denuncia_dp_numero&.positive? }
    validates :denuncia_telefone_resposta, :denuncia_presencial_resposta, :denuncia_mpe_resposta, :denuncia_dp_resposta,
              inclusion: { in: %w[nao insatisfatorio regular bom otimo], allow_blank: true }
  end

  with_options if: -> { page >= 4 } do
    validates :concorda_acordo_trecho,
              numericality: { only_integer: true,
                              less_than_or_equal_to: 5,
                              greater_than_or_equal_to: 1 }
  end

  with_options if: -> { page >= 5 } do
    validates :covid_grupo_risco,
              inclusion: { in: %w[idosos gestantes cronicos] }
    validates :covid_sintomas,
              inclusion: { in: [true, false] }
    validates :covid_atencao_medica,
              presence: true,
              if: -> { page >= 5 && covid_sintomas? }
    validates :covid_testado,
              inclusion: { in: %w[nao rede_publica rede_privada] }
    validates :covid_resultado,
              inclusion: { in: %w[positivo negativo inconclusivo nao_deseja] },
              if: -> { page >= 5 && covid_testado != 'nao' }
  end

  private

  def set_form_page
    self.page = page.to_i
    self.page = 0 unless page.between? 0, 5
  end

  def update_form_page
    self.page += 1 if errors.to_h.except(:page).empty?
  end

  def last_form_page
    return if page == 5

    errors.add :page, 'Formulário não está completo'
  end
end
