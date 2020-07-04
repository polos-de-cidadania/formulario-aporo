# frozen_string_literal: true

module ApplicationHelper
  def title
    if content_for?(:title)
      # allows the title to be set in the view by using t(".title")
      content_for :title
    else
      # look up translation key based on controller path and .title
      t("#{controller_path.tr('/', '.')}.#{action_name}.title", default: :site_name) ||
        t('site_title')
    end
  end
end
