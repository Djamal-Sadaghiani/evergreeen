# frozen_string_literal: true

require 'curb'
require 'json'

class CurrencyExchangeRatesJob < ApplicationJob
  queue_as :default

  def perform
    Currency.all.each do |currency|
      exchange_rate = get_json(currency.currency_ISO)['spark']['result'][0]['response'][0]['meta']['regularMarketPrice']
      currency.exchange_rate_to_EUR = exchange_rate
      currency.touch
      currency.save!
    end
  end

  def get_json(currency)
    url = "https://query1.finance.yahoo.com/v7/finance/spark?symbols=EUR#{currency}%3DX&range=1d&interval=5m&indicators=close&includeTimestamps=false&includePrePost=false&corsDomain=de.finance.yahoo.com&.tsrc=finance"
    data = JSON.parse(Curl.get(url).body_str)
  end
end
