require 'net/http'

class Product < ApplicationRecord
  has_many :trades
  after_create :get_ticker_by_isin

  def get_ticker_by_isin
    uri = URI("https://query2.finance.yahoo.com/v1/finance/search?"
    params = {q: self.isin, quotesCount: 1, newsCount: 0}
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    puts res.body# if res.is_a?(Net::HTTPSuccess)
  end
end

