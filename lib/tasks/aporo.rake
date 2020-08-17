# frozen_string_literal: true

require 'csv'

namespace :aporo do
  desc 'Exportar respostas para arquivo CSV'
  task :exportcsv, %i[password filename] => [:environment] do |_task, rake_args|
    Lockbox.master_key = ENV['LOCKBOX_MASTER_KEY']

    args = {
      password: rake_args[:password] || ENV['LOCKBOX_MASTER_KEY'],
      filename: rake_args[:filename] || 'respostas.csv'
    }

    attributes = FormAnswer.attribute_names.reject { |attr| attr.end_with? '_ciphertext' }
    csv_str = CSV.generate headers: true do |csv|
      csv << attributes

      FormAnswer.all.each do |answer|
        csv << answer.attributes.slice(*attributes).values
      end
    end

    result = IO.popen("npx secure-spreadsheet --password #{args[:password]}", 'r+') do |io|
      io.write(csv_str)
      io.close_write
      io.read
    end
    File.open(Rails.root.join(args[:filename]), 'w') { |f| f.write(result) }
  end
end
