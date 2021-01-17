# frozen_string_literal: true

class AddSharesOutstandingToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :shares_outstanding, :integer, limit: 8
  end
end
