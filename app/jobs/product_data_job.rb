# frozen_string_literal: true

class ProductDataJob < ApplicationJob
  queue_as :yahoo

  def perform
    Product.where('ticker IS NULL').limit(600).each do |product|
      product_data = YahooManager::ProductDataScraper.call({ isin: product.isin })
      product.ticker = product_data&.dig(:ticker)
      product.equity_type = product_data&.dig(:equity_type)
      product.name = product_data&.dig(:name) || product.name
      product.long_name = product_data&.dig(:long_name)
      product.currency_base = product_data&.dig(:currency_base)
      product.save
    end
  end
end
