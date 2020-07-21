# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_raven_context

  protected

  def after_sign_in_path_for(user)
    user_path(user)
  end

  def after_sign_out_path_for(_)
    new_user_session_path
  end

  private

  def set_raven_context
    Raven.user_context(id: request.user_agent) # or anything else in session
    Raven.extra_context(user: current_user&.id)
  end
end
