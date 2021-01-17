# frozen_string_literal: true

class AddTradingViewColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :tradingview_recommendation, :string
    add_column :products, :tradingview_net_recommendation_score, :decimal
  end
end
