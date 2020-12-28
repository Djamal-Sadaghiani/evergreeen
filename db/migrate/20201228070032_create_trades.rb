class CreateTrades < ActiveRecord::Migration[6.0]
  def change
    create_table :trades do |t|
      t.uuid :trade_uuid
      t.string :isin
      t.string :name
      t.datetime :time
      t.integer :price
      t.integer :amount

      t.timestamps
    end
  end
end
