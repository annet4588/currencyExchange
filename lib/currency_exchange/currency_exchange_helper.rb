# The helper module defines a method to return the file path for the exchange data.
module CurrencyExchangeHelper
    def self.exchange_rate_file_path
        Rails.root.join('db', 'data', 'rates.json')
    end
end