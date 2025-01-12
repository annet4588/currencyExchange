module CurrencyExchange
    class JsonRateSource
      def initialize(file_path)
        @file_path = file_path
        @data = load_data
      end
  
      def get_rate(date, currency)
        date_rates = @data[date.to_s]
        raise "No rates available for the date #{date}" if date_rates.nil?
  
        rate = date_rates[currency]
        raise "No rate available for the currency #{currency} on date #{date}" if rate.nil?
  
        rate
      end
  
      private
  
      def load_data
        JSON.parse(File.read(@file_path))
      rescue StandardError => e
        raise "Error loading data from file: #{e.message}"
      end
    end
  
    def self.configure_rate_source(rate_source, base_currency)
      @rate_source = rate_source
      @base_currency = base_currency
    end
  
    def self.rate(date, from_currency, to_currency)
      raise 'Rate source not configured' unless defined?(@rate_source) && @rate_source
  
      from_rate = convert_to_base_currency(date, from_currency)
      to_rate = convert_to_base_currency(date, to_currency)
  
      to_rate / from_rate
    end
  
    def self.convert_to_base_currency(date, currency)
      return 1.0 if currency == @base_currency
  
      @rate_source.get_rate(date, currency)
    end
  end