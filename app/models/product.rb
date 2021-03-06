# frozen_string_literal: true

require 'curb'
require 'json'

class Product < ApplicationRecord
  searchkick
  has_many :trades
  has_many :income_statements
  belongs_to :company, optional: true

  def price
    trades.last&.price
  end

  def marketcap
    price * shares_outstanding
  end

  def price_potential
    return unless !mean_target_price.nil? && !mean_target_price.nil?

    (mean_target_price.to_f / price_yahoo) - 1
  end

  def stock_analyzer
    ProductAnalyzer::StockAnalyzer.call({ price_potential: price_potential,
                                          number_of_analysts: number_of_analysts })
  end
end
