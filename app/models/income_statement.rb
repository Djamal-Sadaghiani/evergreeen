class IncomeStatement < ApplicationRecord
    belongs_to :product
    validates :income_statement_uuid, uniqueness: true
    validates :period, :date, :total_revenue, :gross_profit,:operating_expense,
      :operating_income,:net_non_operating_interest_income_expense,:other_income_expense,
      :pretax_income,:tax_provision,:net_income_common_stockholders,:diluted_ni_available_to_com_stockholders,
      :basic_eps,:diluted_eps,:basic_average_shares,:diluted_average_shares,:total_operating_income_as_reported,
      :total_expenses,:net_income_from_continuing_and_discontinued_operation,:normalized_income,:interest_income,
      :interest_expense,:net_interest_income,:ebit,:ebitda,:reconciled_cost_of_revenue,:reconciled_depreciation,
      :net_income_from_continuing_operation_net_minority_interest,:normalized_ebitda,:tax_rate_for_calcs,
      :tax_effect_of_unusual_items, presence: true
end
