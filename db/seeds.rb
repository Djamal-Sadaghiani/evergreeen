# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def get_json(currency)
  url = "https://query1.finance.yahoo.com/v7/finance/spark?symbols=EUR#{currency}%3DX&range=1d&interval=5m&indicators=close&includeTimestamps=false&includePrePost=false&corsDomain=de.finance.yahoo.com&.tsrc=finance"
  data = JSON.parse(Curl.get(url).body_str)
end

Currency.create(currency_ISO: 'EUR', exchange_rate_to_EUR: 1)
currencies = %w[USD AUD HKD GBP NOK JPY CAD CNY CHF DKK SEK ZAC SGD NZD THB
                IDR]
currencies.each do |currency|
  exchange_rate = get_json(currency)['spark']['result'][0]['response'][0]['meta']['regularMarketPrice']
  Currency.create(currency_ISO: currency, exchange_rate_to_EUR: exchange_rate)
end
