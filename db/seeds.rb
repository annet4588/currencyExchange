# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).


# Uses a helper module CurrencyExchangeHelper to extract the file_path
file_path = CurrencyExchangeHelper.exchange_rate_file_path
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

