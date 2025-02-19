# frozen_string_literal: true

class FormAnswersController < ApplicationController
  before_action :set_form, only: [:create]

  # GET /formulario
  def new
    @form_answer = FormAnswer.new(page: 0)
  end

  # POST /formulario
  def create
    if @form_answer.save
      redirect_to :formulario_fim
    else
      render :new
    end
  end

  def end; end

  private

  # Only allow a trusted parameter "white list" through.
  def form_answer_params # rubocop:disable Metrics/MethodLength
    params.require(:form_answer)
          .permit(:page,
                  :concordo_dados,
                  :concordo_pesquisa,
                  :nome,
                  :cpf,
                  :responsavel_nome,
                  :responsavel_cpf,
                  :genero,
                  :raca,
                  :telefone,
                  :endereco_rua,
                  :endereco_numero,
                  :endereco_complemento,
                  :endereco_cep,
                  :endereco_bairro,
                  :endereco_cidade,
                  :cadastro_digital,
                  :cadastro_dificuldades,
                  :cadastro_dias,
                  :cadastro_tempo,
                  :concorda_acordo_valores,
                  :concorda_acordo_comentario,
                  :pagamento_realizado,
                  :denuncia_telefone_numero,
                  :denuncia_telefone_resposta,
                  :denuncia_telefone_comentario,
                  :denuncia_presencial_numero,
                  :denuncia_presencial_resposta,
                  :denuncia_presencial_comentario,
                  :denuncia_mpe_numero,
                  :denuncia_mpe_resposta,
                  :denuncia_mpe_comentario,
                  :denuncia_dp_numero,
                  :denuncia_dp_resposta,
                  :denuncia_dp_comentario,
                  :denuncia_outros,
                  :concorda_acordo_trecho,
                  :covid_sintomas,
                  :covid_atencao_medica,
                  :covid_testado,
                  :covid_resultado,
                  :duvidas_reclamacoes_sugestoes,
                  covid_grupo_risco: [])
  end

  def set_form
    @form_answer = FormAnswer.new form_answer_params
  end
end
