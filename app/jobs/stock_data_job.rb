# frozen_string_literal: true

class StockDataJob < ApplicationJob
  queue_as :yahoo

  def perform
    Product.where("equity_type = 'EQUITY' AND ticker IS NOT NULL").order(updated_at: :asc).limit(600).each do |product|
      stock_data = YahooManager::StockDataScraper.call({ ticker: product.ticker })
      if product.currency_base == 'EUR'
        product.mean_target_price = stock_data&.dig(:mean_target_price)
        product.price_yahoo = stock_data&.dig(:price_yahoo)
      else
        product.mean_target_price = YahooManager::CurrencyConverter.call({ currency: product.currency_base,
                                                                           amount: stock_data&.dig(:mean_target_price) })
        product.price_yahoo = YahooManager::CurrencyConverter.call({ currency: product.currency_base,
                                                                     amount: stock_data&.dig(:price_yahoo) })
      end
      product.number_of_analysts = stock_data&.dig(:number_of_analysts)
      product.recommendations = stock_data&.dig(:recommendations)
      product.touch
      product.save
        rescue StandardError
      next(product)
    end
  end
end
