class AddcolumnStockAnalyzer < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :stock_analyzer, :string
  end
end
