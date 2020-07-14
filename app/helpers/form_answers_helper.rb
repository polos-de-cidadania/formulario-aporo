# frozen_string_literal: true

module FormAnswersHelper
  def active_section(section_n)
    @form_answer.page == section_n # rubocop:disable Rails/HelperInstanceVariable
  end
end
