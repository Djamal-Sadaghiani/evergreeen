# frozen_string_literal: true

require 'curb'
require 'json'

class Product < ApplicationRecord
  searchkick
  has_many :trades
  has_many :income_statements

  def price
    trades.last&.price
  end

  def price_potential
    return unless mean_target_price && mean_target_price&.positive?

    mean_target_price / price_yahoo - 1
  end

  def stock_analyzer
    ProductAnalyzer::StockAnalyzer.call({ price_potential: price_potential,
                                          number_of_analysts: number_of_analysts })
  end
end
