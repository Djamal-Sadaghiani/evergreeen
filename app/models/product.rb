require 'curb'
require 'json'
require 'money'

class Product < ApplicationRecord
  has_many :trades, :income_statements
  after_create :update_meta_data

  def get_price
    self.trades.last&.price
  end

  def update_meta_data
    base_url = "https://query2.finance.yahoo.com/v1/finance/search?"
    params = {q: self.isin, quotesCount: 1, newsCount: 0}
    response = Curl.get(base_url, params)
    p response
    begin
    json = JSON.parse(response.body_str)
      self.ticker = json['quotes'][0]['symbol'] if json['quotes'][0]['symbol']
      self.equity_type = json['quotes'][0]['quoteType'] if json['quotes'][0]['quoteType']
      self.name = json['quotes'][0]['shortname'] if json['quotes'][0]['shortname']
      self.long_name = json['quotes'][0]['longname'] if json['quotes'][0]['longname']
      self.save
      get_analyst_ratings if self.equity_type == 'EQUITY'
    rescue
    end
  end

  def get_stockdata_by_ticker
    url = "https://query2.finance.yahoo.com/v10/finance/quoteSummary/#{self.ticker}?modules=financialData"
    JSON.parse(Curl.get(url).body_str)
  end

  def get_exchange_rate_by_iso
    url = "https://query1.finance.yahoo.com/v7/finance/spark?symbols=EUR#{self.currency_base}%3DX&range=1d&interval=5m&indicators=close&includeTimestamps=false&includePrePost=false&corsDomain=de.finance.yahoo.com&.tsrc=finance" 
    JSON.parse(Curl.get(url).body_str)
  end

  def get_currency_base
    url = "https://query2.finance.yahoo.com/v7/finance/quote?formatted=true&crumb=HHMob3hrkL9&lang=de-DE&region=DE&symbols=#{self.ticker}&fields=messageBoardId%2ClongName%2CshortName%2CmarketCap%2CunderlyingSymbol%2CunderlyingExchangeSymbol%2CheadSymbolAsString%2CregularMarketPrice%2CregularMarketChange%2CregularMarketChangePercent%2CregularMarketVolume%2Cuuid%2CregularMarketOpen%2CfiftyTwoWeekLow%2CfiftyTwoWeekHigh%2CtoCurrency%2CfromCurrency%2CtoExchange%2CfromExchange&corsDomain=de.finance.yahoo.com"
    JSON.parse(Curl.get(url).body_str)
  end

  def get_analyst_ratings
    #begin
      data = get_stockdata_by_ticker()
      return if data['quoteSummary']['result'].nil?
      record = data['quoteSummary']['result'][0]['financialData']
      self.recommendations = record['recommendationMean']['raw']
      self.currency_base = get_currency_base['quoteResponse']['result'][0]['currency'] if !get_currency_base['quoteResponse']['result'].nil?
      p "Default Currency: EUR"
      p "Currency: "
      p self.currency_base

      if self.currency_base == "EUR" 
        self.mean_target_price = (record['targetMeanPrice']['raw'].to_f) * 10000
        self.price_yahoo = (record['currentPrice']['raw'].to_f) * 10000
      else
        exchange_rate = get_exchange_rate_by_iso['spark']['result'][0]['response'][0]['meta']['regularMarketPrice']
        p get_exchange_rate_by_iso['spark']['result'][0]['response']
        p exchange_rate
        self.mean_target_price = (record['targetMeanPrice']['raw'].to_f) * 10000 / exchange_rate       
        self.price_yahoo = (record['currentPrice']['raw'].to_f) * 10000 / exchange_rate 
      end 
      self.number_of_analysts = record['numberOfAnalystOpinions']['fmt']
      self.price_potential = ((record['targetMeanPrice']['raw'].to_f / record['currentPrice']['raw'].to_f)-1) if !record['targetMeanPrice']['raw'].to_f.nil? && record['targetMeanPrice']['raw'].to_f > 0
      self.save
    #rescue
    #end
  end

end
