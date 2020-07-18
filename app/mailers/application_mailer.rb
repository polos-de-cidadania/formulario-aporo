# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'Plataforma Áporo <sistema.aporo@polosdecidadania.com.br>'
  default reply_to: 'Plataforma Áporo <aporo@polosdecidadania.com.br>'

  default charset: 'utf-8'
  layout 'mailer'
end
