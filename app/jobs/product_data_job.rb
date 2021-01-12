# frozen_string_literal: true

class ProductDataJob < ApplicationJob
  queue_as :yahoo

  def perform
    Product.where('ticker IS NULL').limit(600).each do |product|
      product_data = YahooManager::ProductDataScraper.call({ isin: product.isin })
      product.ticker = product_data&.dig(:ticker)
      create_or_find_company(product) if !product.ticker.nil?
      product.equity_type = product_data&.dig(:equity_type)
      product.name = product_data&.dig(:name) || product.name
      product.long_name = product_data&.dig(:long_name)
      product.currency_base = product_data&.dig(:currency_base)
      product.save
    end
  end

  def create_or_find_company(product)
    company = Company.where('ticker = ?', product.ticker)
    if company.empty?
      company = Company.create(ticker: product.ticker)
      product.company = company
      product.save
      company.save
    else
      product.company = company.first
      product.save
      company.save
    end
  end
end
