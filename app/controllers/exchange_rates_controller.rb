class ExchangeRatesController < ApplicationController
    def index
        @rate = nil
        # For showing a list of rates or a form
        if params[:date].present? && params[:from_currency].present? && params[:to_currency].present?
            date = params[:date]
            from_currency = params[:from_currency]
            to_currency = params[:to_currency]
   
            # For displaying a specific exchange rate
            begin
               @rate = CurrencyExchange.rate(date, from_currency, to_currency)
            rescue => e
                flash[:alert] = "Error fetching the exchange rate: #{e.message}"
            end
        else
          # Optionally, add some error handling if params are missing
          flash[:alert] = "Please provide a valid date, from currency, and to currency."
        end
    end
end
