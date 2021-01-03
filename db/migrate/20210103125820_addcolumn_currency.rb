class AddcolumnCurrency < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :currency_base, :string 
  end
end
