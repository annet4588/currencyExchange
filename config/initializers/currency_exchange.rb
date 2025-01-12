# Require the CurrencyExchange module and its nested JsonRateSource class
require Rails.root.join('lib', 'currency_exchange', 'currency_exchange')

file_path = Rails.root.join('db', 'data', 'rates.json')
if File.exist?(file_path)
  CurrencyExchange.configure_rate_source(CurrencyExchange::JsonRateSource.new(file_path), 'EUR')
else
  Rails.logger.error("Exchange rates file not found at #{file_path}")
end