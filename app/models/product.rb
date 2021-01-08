require 'curb'
require 'json'

class Product < ApplicationRecord
  has_many :trades
  has_many :income_statements
  after_create :update_meta_data

  def get_price
    trades.last&.price
  end

  def update_meta_data
    base_url = 'https://query2.finance.yahoo.com/v1/finance/search?'
    params = { q: isin, quotesCount: 1, newsCount: 0 }
    response = Curl.get(base_url, params)
    begin
      json = JSON.parse(response.body_str)
      self.ticker = json['quotes'][0]['symbol'] if json['quotes'][0]['symbol']
      self.equity_type = json['quotes'][0]['quoteType'] if json['quotes'][0]['quoteType']
      self.name = json['quotes'][0]['shortname'] if json['quotes'][0]['shortname']
      self.long_name = json['quotes'][0]['longname'] if json['quotes'][0]['longname']
      save
      get_analyst_ratings if equity_type == 'EQUITY'
    rescue StandardError
    end
  end

  def get_stockdata_by_ticker
    url = "https://query2.finance.yahoo.com/v10/finance/quoteSummary/#{ticker}?modules=financialData"
    JSON.parse(Curl.get(url).body_str)
  end

  def get_currency_base
    url = "https://query2.finance.yahoo.com/v7/finance/quote?formatted=true&crumb=HHMob3hrkL9&lang=de-DE&region=DE&symbols=#{ticker}&fields=messageBoardId%2ClongName%2CshortName%2CmarketCap%2CunderlyingSymbol%2CunderlyingExchangeSymbol%2CheadSymbolAsString%2CregularMarketPrice%2CregularMarketChange%2CregularMarketChangePercent%2CregularMarketVolume%2Cuuid%2CregularMarketOpen%2CfiftyTwoWeekLow%2CfiftyTwoWeekHigh%2CtoCurrency%2CfromCurrency%2CtoExchange%2CfromExchange&corsDomain=de.finance.yahoo.com"
    JSON.parse(Curl.get(url).body_str)
  end

  def get_analyst_ratings
    data = get_stockdata_by_ticker
    return if data['quoteSummary']['result'].nil?

    record = data['quoteSummary']['result'][0]['financialData']
    self.recommendations = record['recommendationMean']['raw']
    unless get_currency_base['quoteResponse']['result'].nil?
      self.currency_base = get_currency_base['quoteResponse']['result'][0]['currency']
    end

    if currency_base == 'EUR'
      self.mean_target_price = record['targetMeanPrice']['raw'].to_f * 10_000
      self.price_yahoo = record['currentPrice']['raw'].to_f * 10_000
    else
      self.mean_target_price = YahooManager::CurrencyConverter.call({ currency: currency_base,
                                                                      amount: (record['targetMeanPrice']['raw'].to_f * 10_000) })
      self.price_yahoo = YahooManager::CurrencyConverter.call({ currency: currency_base,
                                                                amount: (record['currentPrice']['raw'].to_f * 10_000) })
    end
    self.number_of_analysts = record['numberOfAnalystOpinions']['fmt']
    if !record['targetMeanPrice']['raw'].to_f.nil? && record['targetMeanPrice']['raw'].to_f > 0
      self.price_potential = ((record['targetMeanPrice']['raw'].to_f / record['currentPrice']['raw']) - 1)
    end
    save
  end

  def get_price_potential
    (((mean_target_price.to_f / get_price) - 1) * 100) if !mean_target_price.nil? && !get_price.nil?
    # binding.pry
  end
end
