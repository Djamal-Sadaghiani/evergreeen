class Addcolumn < ActiveRecord::Migration[6.0]
  def change
    change_column :products, :recommendations, :float
    add_column :products, :price_potential, :decimal 
  end
end
