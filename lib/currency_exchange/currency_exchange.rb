# Module is defined as a container for classes and methods related to currency exchange functionality.
# Encapsulate the logic for handling exchange rates and computation.
module CurrencyExchange

  # Class to read exchange rates from a JSON file and provide access to specific rates.
    class JsonRateSource
      # Constructor method to initialise an object of JsonRateSource.
      # param - file_path
      # instance vars - @file_path to store file path and 
      #               - @data to store the parsed JSON data by calling the load_data method
      def initialize(file_path)
        @file_path = file_path
        @data = load_data
      end
  
      # Method retrives the exchange rate for a specific date and currency.
      def get_rate(date, currency)
        date_rates = @data[date.to_s]
        raise "No rates available for the date #{date}" if date_rates.nil?
  
        rate = date_rates[currency]
        raise "No rate available for the currency #{currency} on date #{date}" if rate.nil?
  
        rate
      end
  
      # Method reads the JSON file and parses its contents into a Ruby hash.
      private
  
      def load_data
        JSON.parse(File.read(@file_path))
      rescue StandardError => e
        raise "Error loading data from file: #{e.message}"
      end
    end
  
    # Method configures the module by setting a rate source and a base currency.
    # params - rate_source to provide access to exchange rates
    #        - base_currency code against which all rates are calculated (e.g. 'EUR')
    def self.configure_rate_source(rate_source, base_currency)
      @rate_source = rate_source
      @base_currency = base_currency
    end
  
    # Method computes the exchange rate between two currencies on a specific date.
    # params - date for which the conversion requested
    #        - from_currency the source currency code
    #        - to_currency the target currency code
    def self.rate(date, from_currency, to_currency)
      raise 'Rate source not configured' unless defined?(@rate_source) && @rate_source
  
      from_rate = convert_to_base_currency(date, from_currency)
      to_rate = convert_to_base_currency(date, to_currency)
  
      to_rate / from_rate
    end
  
    # Method converts a currency to the base currency using the exchange rate for a given date.
    def self.convert_to_base_currency(date, currency)
      return 1.0 if currency == @base_currency
  
      @rate_source.get_rate(date, currency)
    end
  end