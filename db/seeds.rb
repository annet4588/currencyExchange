# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

file_path = Rails.root.join('db', 'data', 'rates.json')
if File.exist?(file_path)
    rates = JSON.parse(File.read(file_path))

    rates.each do |date, currencies|
        currencies.each do |currency, rate|
            ExchangeRate.create(date: date, currency: currency, rate: rate)
        end
    end
else
    Rails.logger.error("Exchange rates file not found at #{file_path}")
end

