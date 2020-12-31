class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :isin, null: false
      t.string :name, null: false
      t.string :long_name
      t.integer :recommendations
      t.integer :mean_target_price
      t.integer :number_of_analysts
      t.string :ticker
      t.string :equity_type

      t.timestamps
    end

    add_index :products, :isin, unique: true
  end
end
