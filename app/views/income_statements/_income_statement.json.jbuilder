# frozen_string_literal: true

json.extract! income_statement, :id, :period, :date, :total_revenue, :cost_of_revenue, :gross_profit,
              :operating_expense, :operating_income, :net_non_operating_interest_income_expense, :other_income_expense, :pretax_income, :tax_provision, :net_income_common_stockholders, :diluted_ni_available_to_com_stockholders, :basic_eps, :diluted_eps, :basic_average_shares, :diluted_average_shares, :total_operating_income_as_reported, :total_expenses, :net_income_from_continuing_and_discontinued_operation, :normalized_income, :interest_income, :interest_expense, :net_interest_income, :ebit, :ebitda, :reconciled_cost_of_revenue, :reconciled_depreciation, :net_income_from_continuing_operation_net_minority_interest, :normalized_ebitda, :tax_rate_for_calcs, :tax_effect_of_unusual_items, :created_at, :updated_at
json.url income_statement_url(income_statement, format: :json)
