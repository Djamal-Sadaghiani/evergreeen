# frozen_string_literal: true

require 'curb'
require 'json'

module YahooManager
  class CurrencyConverter < ApplicationService
    def initialize(params)
      @currency = params[:currency]
      @amount = params[:amount]
    end

    # ISO code as input e.g. "USD"
    def call
      @amount / Currency.find_by_currency_ISO(@currency).exchange_rate_to_EUR
    end
  end
end
