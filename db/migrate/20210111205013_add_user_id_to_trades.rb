class AddUserIdToTrades < ActiveRecord::Migration[6.0]
  def change
    add_reference :trades, :user, foreign_key: true
    add_column :trades, :investment_hypothesis, :string
    add_column :trades, :transaction_cost, :integer
  end
end
