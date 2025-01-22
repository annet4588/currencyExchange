# Require the CurrencyExchange module and its nested JsonRateSource class
require Rails.root.join('lib', 'currency_exchange', 'currency_exchange_helper')
require Rails.root.join('lib', 'currency_exchange', 'currency_exchange')

# Uses a helper module CurrencyExchangeHelper to extract the file path.
file_path = CurrencyExchangeHelper.exchange_rate_file_path
if File.exist?(file_path)
  CurrencyExchange.configure_rate_source(CurrencyExchange::JsonRateSource.new(file_path), 'EUR')
else
  Rails.logger.error("Exchange rates file not found at #{file_path}")
end