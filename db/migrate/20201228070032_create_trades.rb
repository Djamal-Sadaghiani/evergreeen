# frozen_string_literal: true

class CreateTrades < ActiveRecord::Migration[6.0]
  def change
    create_table :trades do |t|
      t.string :trade_uuid, null: false
      t.string :isin, null: false
      t.string :name, null: false
      t.datetime :time, null: false
      t.integer :price, null: false
      t.integer :amount, null: false
      t.references :product, foreign_key: true

      t.timestamps
    end

    add_index :trades, :trade_uuid, unique: true
  end
end
