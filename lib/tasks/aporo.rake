# frozen_string_literal: true

require 'csv'

namespace :aporo do
  desc 'Exportar respostas para arquivo CSV'
  task exportcsv: :environment do
    attributes = FormAnswer.attribute_names.reject { |attr| attr.end_with? '_ciphertext' }

    to_csv_block = lambda do |csv|
      csv << attributes

      FormAnswer.all.each do |answer|
        csv << answer.attributes.slice(*attributes).values
      end
    end

    if ARGV[1]
      CSV.open Rails.root.join(ARGV[1]), 'wb', headers: true, &to_csv_block
    else
      puts CSV.generate headers: true, &to_csv_block
    end
  end
end
