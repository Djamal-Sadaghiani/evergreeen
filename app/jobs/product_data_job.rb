# frozen_string_literal: true

class ProductDataJob < ApplicationJob
  queue_as :yahoo

  def perform
    i = 1
    Product.where('ticker IS NULL').each do |product|
      sleep(1.hour) if i % 600 == 0
      product_data = YahooManager::ProductDataScraper.call({ isin: product.isin })
      product.ticker = product_data&.dig(:ticker)
      product.equity_type = product_data&.dig(:equity_type)
      product.name = product_data&.dig(:name) || product.name
      product.long_name = product_data&.dig(:long_name)
      product.currency_base = product_data&.dig(:currency_base)
      product.save
      i += 1
    end
  end
end
