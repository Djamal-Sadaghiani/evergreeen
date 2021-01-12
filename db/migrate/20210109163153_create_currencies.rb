# frozen_string_literal: true

class CreateCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :currencies do |t|
      t.string :currency_ISO
      t.float :exchange_rate_to_EUR

      t.timestamps
    end
    add_index :currencies, :currency_ISO, unique: true
  end
end
