# frozen_string_literal: true

require 'test_helper'

class IncomeStatementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @income_statement = income_statements(:one)
  end

  test 'should get index' do
    get income_statements_url
    assert_response :success
  end

  test 'should get new' do
    get new_income_statement_url
    assert_response :success
  end

  test 'should create income_statement' do
    assert_difference('IncomeStatement.count') do
      post income_statements_url,
           params: { income_statement: { basic_average_shares: @income_statement.basic_average_shares,
                                         basic_eps: @income_statement.basic_eps, cost_of_revenue: @income_statement.cost_of_revenue, date: @income_statement.date, diluted_average_shares: @income_statement.diluted_average_shares, diluted_eps: @income_statement.diluted_eps, diluted_ni_available_to_com_stockholders: @income_statement.diluted_ni_available_to_com_stockholders, ebit: @income_statement.ebit, ebitda: @income_statement.ebitda, gross_profit: @income_statement.gross_profit, interest_expense: @income_statement.interest_expense, interest_income: @income_statement.interest_income, net_income_common_stockholders: @income_statement.net_income_common_stockholders, net_income_from_continuing_and_discontinued_operation: @income_statement.net_income_from_continuing_and_discontinued_operation, net_income_from_continuing_operation_net_minority_interest: @income_statement.net_income_from_continuing_operation_net_minority_interest, net_interest_income: @income_statement.net_interest_income, net_non_operating_interest_income_expense: @income_statement.net_non_operating_interest_income_expense, normalized_ebitda: @income_statement.normalized_ebitda, normalized_income: @income_statement.normalized_income, operating_expense: @income_statement.operating_expense, operating_income: @income_statement.operating_income, other_income_expense: @income_statement.other_income_expense, period: @income_statement.period, pretax_income: @income_statement.pretax_income, reconciled_cost_of_revenue: @income_statement.reconciled_cost_of_revenue, reconciled_depreciation: @income_statement.reconciled_depreciation, tax_effect_of_unusual_items: @income_statement.tax_effect_of_unusual_items, tax_provision: @income_statement.tax_provision, tax_rate_for_calcs: @income_statement.tax_rate_for_calcs, total_expenses: @income_statement.total_expenses, total_operating_income_as_reported: @income_statement.total_operating_income_as_reported, total_revenue: @income_statement.total_revenue } }
    end

    assert_redirected_to income_statement_url(IncomeStatement.last)
  end

  test 'should show income_statement' do
    get income_statement_url(@income_statement)
    assert_response :success
  end

  test 'should get edit' do
    get edit_income_statement_url(@income_statement)
    assert_response :success
  end

  test 'should update income_statement' do
    patch income_statement_url(@income_statement),
          params: { income_statement: { basic_average_shares: @income_statement.basic_average_shares,
                                        basic_eps: @income_statement.basic_eps, cost_of_revenue: @income_statement.cost_of_revenue, date: @income_statement.date, diluted_average_shares: @income_statement.diluted_average_shares, diluted_eps: @income_statement.diluted_eps, diluted_ni_available_to_com_stockholders: @income_statement.diluted_ni_available_to_com_stockholders, ebit: @income_statement.ebit, ebitda: @income_statement.ebitda, gross_profit: @income_statement.gross_profit, interest_expense: @income_statement.interest_expense, interest_income: @income_statement.interest_income, net_income_common_stockholders: @income_statement.net_income_common_stockholders, net_income_from_continuing_and_discontinued_operation: @income_statement.net_income_from_continuing_and_discontinued_operation, net_income_from_continuing_operation_net_minority_interest: @income_statement.net_income_from_continuing_operation_net_minority_interest, net_interest_income: @income_statement.net_interest_income, net_non_operating_interest_income_expense: @income_statement.net_non_operating_interest_income_expense, normalized_ebitda: @income_statement.normalized_ebitda, normalized_income: @income_statement.normalized_income, operating_expense: @income_statement.operating_expense, operating_income: @income_statement.operating_income, other_income_expense: @income_statement.other_income_expense, period: @income_statement.period, pretax_income: @income_statement.pretax_income, reconciled_cost_of_revenue: @income_statement.reconciled_cost_of_revenue, reconciled_depreciation: @income_statement.reconciled_depreciation, tax_effect_of_unusual_items: @income_statement.tax_effect_of_unusual_items, tax_provision: @income_statement.tax_provision, tax_rate_for_calcs: @income_statement.tax_rate_for_calcs, total_expenses: @income_statement.total_expenses, total_operating_income_as_reported: @income_statement.total_operating_income_as_reported, total_revenue: @income_statement.total_revenue } }
    assert_redirected_to income_statement_url(@income_statement)
  end

  test 'should destroy income_statement' do
    assert_difference('IncomeStatement.count', -1) do
      delete income_statement_url(@income_statement)
    end

    assert_redirected_to income_statements_url
  end
end
