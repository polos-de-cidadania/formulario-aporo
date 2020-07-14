# frozen_string_literal: true

module FormAnswersHelper
  def active_section(section_n)
    @form_answer.page == section_n # rubocop:disable Rails/HelperInstanceVariable
  end

  def concordo_collection
    { 'Concordo': true, 'Não concordo': false }
  end

  def form_section(active)
    { data: { target: 'form-nav.section' }, class: ('active' if active) }
  end
end
