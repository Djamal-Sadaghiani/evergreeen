class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :isin
      t.string :name
      t.integer :recommendations
      t.integer :mean_target_price
      t.integer :number_of_analysts
      t.string :ticker

      t.timestamps
    end
  end
end
