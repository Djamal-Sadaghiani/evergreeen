class AddcolumnPriceYahoo < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :price_yahoo, :integer 
  end
end
