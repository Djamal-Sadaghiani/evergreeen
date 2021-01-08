# frozen_string_literal: true

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
    product_data = YahooManager::ProductDataScraper.call({ isin: isin })

    self.ticker = product_data[:ticker]
    self.equity_type = product_data[:equity_type]
    self.name = product_data[:name]
    self.long_name = product_data[:long_name]
    self.recommendations = product_data[:recommendations]
    self.currency_base = product_data[:currency_base]
    self.mean_target_price = product_data[:mean_target_price]
    self.price_yahoo = product_data[:price_yahoo]
    self.number_of_analysts = product_data[:number_of_analysts]
    self.price_potential = product_data[:price_potential]

    self.stock_analyzer = ProductAnalyzer::StockAnalyzer.call({ price_potential: price_potential,
                                                                number_of_analysts: number_of_analysts })

    save
  end
end
