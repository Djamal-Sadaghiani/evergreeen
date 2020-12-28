class Trade < ApplicationRecord
  belongs_to :product, optional: true
  validates :name, :isin, :amount, :price, :time, :trade_uuid, presence: true
  validates :trade_uuid, uniqueness: true
  after_create :create_or_find_product

  private

  def create_or_find_product
    product = Product.where("isin = ?", self.isin)
    if product.empty?
      product = Product.create(name: self.name, isin: self.isin)
      self.product = p
      self.save
    else 
      self.product = product.first
      self.save
    end
  end

end
