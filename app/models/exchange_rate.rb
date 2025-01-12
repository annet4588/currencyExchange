class ExchangeRate < ApplicationRecord
    def self.configure_rate_source(file_path, base_currency)
      CurrencyExchange.configure_rate_source(CurrencyExchange::JsonRateSource.new(file_path), base_currency)
    end
  
    def self.rate(date, from_currency, to_currency)
      CurrencyExchange.rate(date, from_currency, to_currency)
    end
  end