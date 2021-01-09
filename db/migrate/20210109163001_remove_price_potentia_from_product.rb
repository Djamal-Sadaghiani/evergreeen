# frozen_string_literal: true

class RemovePricePotentiaFromProduct < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :price_potential, :decimal
    remove_column :products, :stock_analyzer, :string
  end
end
