# This class handles the logic for displaying exchange rates 
# by processing user inputs(date, from_currency, to_currency),
# and fetching the correcponding exchange rate to user.

class ExchangeRatesController < ApplicationController

    # Method handles the logic when user visits the 'index' page.
    def index
        # Initialising the instance var to ensure it's empty at start.
        @rate = nil
        # Checking if user provided all params - date, from_currency, to_currency
        if params[:date].present? && params[:from_currency].present? && params[:to_currency].present?
            
            # Assign the provided params to local vars.
            date = params[:date]
            from_currency = params[:from_currency]
            to_currency = params[:to_currency]
   
            # Fetching exchange rate using CurrencyExchange module.
            begin
               @rate = CurrencyExchange.rate(date, from_currency, to_currency)
            rescue => e
                flash[:alert] = "Error fetching the exchange rate: #{e.message}"
            end
        else
          # If params are missing, a flash alert pops up to inform the user.
          flash[:alert] = "Please provide valid values for the Date, From Currency, and To Currency fields."
        end
    end
end
