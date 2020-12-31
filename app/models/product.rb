require 'curb'
require 'json'

class Product < ApplicationRecord
  has_many :trades
  after_create :update_meta_data

  def get_price
    self.trades.last.price
  end

  def update_meta_data
    base_url = "https://query2.finance.yahoo.com/v1/finance/search?"
    params = {q: self.isin, quotesCount: 1, newsCount: 0}
    response = Curl.get(base_url, params)
    begin
    json = JSON.parse(response.body_str)
      self.ticker = json['quotes'][0]['symbol'] if json['quotes'][0]['symbol']
      self.type = json['quotes'][0]['quoteType'] if json['quotes'][0]['quoteType']
      self.name = json['quotes'][0]['shortname'] if json['quotes'][0]['shortname']
      self.long_name = json['quotes'][0]['longname'] if json['quotes'][0]['longname']
      self.save
      get_analyst_ratings if self.type == 'EQUITY'
    rescue
    end
  end

  def get_stockdata_by_ticker
    url = "https://query2.finance.yahoo.com/v10/finance/quoteSummary/#{self.ticker}?modules=financialData"
    JSON.parse(Curl.get(url).body_str)
  end

  def get_analyst_ratings
    begin
      data = get_stockdata_by_ticker()
      return if data['quoteSummary']['result'].nil?
      record = data['quoteSummary']['result'][0]['financialData']
      self.recommendations = record['recommendationMean']['fmt']
      self.mean_target_price = record['targetMeanPrice']['fmt']
      self.number_of_analysts = record['numberOfAnalystOpinions']['fmt']
      self.save
    rescue
    end
  end

end
