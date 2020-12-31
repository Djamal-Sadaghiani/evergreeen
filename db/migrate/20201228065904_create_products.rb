class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :isin, null: false
      t.string :name, null: false
      t.integer :recommendations
      t.integer :mean_target_price
      t.integer :number_of_analysts
      t.string :ticker
      t.string :type

      t.timestamps
    end

    add_index :products, :isin, unique: true
  end
end
