# frozen_string_literal: true

Lockbox.master_key =
  if Rails.env.production?
    ENV['LOCKBOX_MASTER_KEY']
  else
    '0000000000000000000000000000000000000000000000000000000000000000'
  end

Lockbox.default_options = { encode: false }
