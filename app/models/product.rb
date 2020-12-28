require 'curb'
require 'json'

class Product < ApplicationRecord
  has_many :trades
  after_create :get_ticker_by_isin, :get_analyst_ratings

  def get_ticker_by_isin
    base_url = "https://query2.finance.yahoo.com/v1/finance/search?"
    params = {q: self.isin, quotesCount: 1, newsCount: 0}
    response = Curl.get(base_url, params)
    json = JSON.parse(response.body_str)
    self.ticker = json['quotes'][0]['symbol'] if json['quotes'][0]['symbol']
    self.save
  end

  def get_stockdata_by_ticker
    url = "https://query2.finance.yahoo.com/v10/finance/quoteSummary/#{self.ticker}?modules=financialData"
    JSON.parse(Curl.get(url).body_str)
  end

  def get_analyst_ratings
    data = get_stockdata_by_ticker()
    return if data['quoteSummary']['result'].nil?
    record = data['quoteSummary']['result'][0]['financialData']
    self.recommendations = record['recommendationMean']['fmt']
    self.mean_target_price = record['targetMeanPrice']['fmt']
    self.number_of_analysts = record['numberOfAnalystOpinions']['fmt']
    self.save
  end
end
