# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'Plataforma Áporo <sistema.aporo@polosdecidadania.com>'
  layout 'mailer'
end
