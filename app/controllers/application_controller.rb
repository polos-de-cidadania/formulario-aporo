# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protected

  def after_sign_in_path_for(user)
    user_path(user)
  end

  def after_sign_out_path_for(_)
    new_user_session_path
  end
end
