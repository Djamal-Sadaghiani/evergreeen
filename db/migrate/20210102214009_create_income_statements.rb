class CreateIncomeStatements < ActiveRecord::Migration[6.0]
  def change
    create_table :income_statements do |t|
      t.string :period
      t.date :date
      t.integer :total_revenue
      t.integer :cost_of_revenue
      t.integer :gross_profit
      t.integer :operating_expense
      t.integer :operating_income
      t.integer :net_non_operating_interest_income_expense
      t.integer :other_income_expense
      t.integer :pretax_income
      t.integer :tax_provision
      t.integer :net_income_common_stockholders
      t.integer :diluted_ni_available_to_com_stockholders
      t.integer :basic_eps
      t.integer :diluted_eps
      t.integer :basic_average_shares
      t.integer :diluted_average_shares
      t.integer :total_operating_income_as_reported
      t.integer :total_expenses
      t.integer :net_income_from_continuing_and_discontinued_operation
      t.integer :normalized_income
      t.integer :interest_income
      t.integer :interest_expense
      t.integer :net_interest_income
      t.integer :ebit
      t.integer :ebitda
      t.integer :reconciled_cost_of_revenue
      t.integer :reconciled_depreciation
      t.integer :net_income_from_continuing_operation_net_minority_interest
      t.integer :normalized_ebitda
      t.integer :tax_rate_for_calcs
      t.integer :tax_effect_of_unusual_items
      t.references :product, foreign_key: true
      t.string :income_statement_uuid, null: false

      t.timestamps
    end

    add_index :income_statements, :income_statement_uuid, unique: true


  end
end
