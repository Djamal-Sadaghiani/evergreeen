require 'curb'
require 'json'

class Product < ApplicationRecord
  has_many :trades
  has_many :income_statements
  after_create :update_meta_data

  def get_price
    self.trades.last&.price
  end

  def update_meta_data
    product_data = YahooManager::ProductDataScraper.call({isin: self.isin})

    self.ticker = product_data.dig(:ticker)
    self.equity_type = product_data.dig(:equity_type)
    self.name = product_data.dig(:name)
    self.long_name = product_data.dig(:long_name)
    self.recommendations = product_data.dig(:recommendations)
    self.currency_base = product_data.dig(:currency_base)
    self.mean_target_price = product_data.dig(:mean_target_price)
    self.price_yahoo = product_data.dig(:price_yahoo)
    self.number_of_analysts = product_data.dig(:number_of_analysts)
    self.price_potential = product_data.dig(:price_potential)

    self.stock_analyzer = ProductAnalyzer::StockAnalyzer.call({price_potential: self.price_potential, number_of_analysts: self.number_of_analysts})

    self.save
  end

end
