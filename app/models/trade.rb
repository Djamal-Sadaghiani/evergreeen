# frozen_string_literal: true

class Trade < ApplicationRecord
  belongs_to :product, optional: true
  validates :name, :isin, :amount, :price, :time, :trade_uuid, presence: true
  validates :trade_uuid, uniqueness: true
  after_create :create_or_find_product

  private

  def create_or_find_product
    product = Product.where('isin = ?', isin)
    if product.empty?
      product = Product.create(name: name, isin: isin)
      self.product = product
      save
    else
      self.product = product.first
      save
    end
  end
end
