# frozen_string_literal: true

require 'application_system_test_case'

class IncomeStatementsTest < ApplicationSystemTestCase
  setup do
    @income_statement = income_statements(:one)
  end

  test 'visiting the index' do
    visit income_statements_url
    assert_selector 'h1', text: 'Income Statements'
  end

  test 'creating a Income statement' do
    visit income_statements_url
    click_on 'New Income Statement'

    fill_in 'Basic average shares', with: @income_statement.basic_average_shares
    fill_in 'Basic eps', with: @income_statement.basic_eps
    fill_in 'Cost of revenue', with: @income_statement.cost_of_revenue
    fill_in 'Date', with: @income_statement.date
    fill_in 'Diluted average shares', with: @income_statement.diluted_average_shares
    fill_in 'Diluted eps', with: @income_statement.diluted_eps
    fill_in 'Diluted ni available to com stockholders', with: @income_statement.diluted_ni_available_to_com_stockholders
    fill_in 'Ebit', with: @income_statement.ebit
    fill_in 'Ebitda', with: @income_statement.ebitda
    fill_in 'Gross profit', with: @income_statement.gross_profit
    fill_in 'Interest expense', with: @income_statement.interest_expense
    fill_in 'Interest income', with: @income_statement.interest_income
    fill_in 'Net income common stockholders', with: @income_statement.net_income_common_stockholders
    fill_in 'Net income from continuing and discontinued operation',
            with: @income_statement.net_income_from_continuing_and_discontinued_operation
    fill_in 'Net income from continuing operation net minority interest',
            with: @income_statement.net_income_from_continuing_operation_net_minority_interest
    fill_in 'Net interest income', with: @income_statement.net_interest_income
    fill_in 'Net non operating interest income expense',
            with: @income_statement.net_non_operating_interest_income_expense
    fill_in 'Normalized ebitda', with: @income_statement.normalized_ebitda
    fill_in 'Normalized income', with: @income_statement.normalized_income
    fill_in 'Operating expense', with: @income_statement.operating_expense
    fill_in 'Operating income', with: @income_statement.operating_income
    fill_in 'Other income expense', with: @income_statement.other_income_expense
    fill_in 'Period', with: @income_statement.period
    fill_in 'Pretax income', with: @income_statement.pretax_income
    fill_in 'Reconciled cost of revenue', with: @income_statement.reconciled_cost_of_revenue
    fill_in 'Reconciled depreciation', with: @income_statement.reconciled_depreciation
    fill_in 'Tax effect of unusual items', with: @income_statement.tax_effect_of_unusual_items
    fill_in 'Tax provision', with: @income_statement.tax_provision
    fill_in 'Tax rate for calcs', with: @income_statement.tax_rate_for_calcs
    fill_in 'Total expenses', with: @income_statement.total_expenses
    fill_in 'Total operating income as reported', with: @income_statement.total_operating_income_as_reported
    fill_in 'Total revenue', with: @income_statement.total_revenue
    click_on 'Create Income statement'

    assert_text 'Income statement was successfully created'
    click_on 'Back'
  end

  test 'updating a Income statement' do
    visit income_statements_url
    click_on 'Edit', match: :first

    fill_in 'Basic average shares', with: @income_statement.basic_average_shares
    fill_in 'Basic eps', with: @income_statement.basic_eps
    fill_in 'Cost of revenue', with: @income_statement.cost_of_revenue
    fill_in 'Date', with: @income_statement.date
    fill_in 'Diluted average shares', with: @income_statement.diluted_average_shares
    fill_in 'Diluted eps', with: @income_statement.diluted_eps
    fill_in 'Diluted ni available to com stockholders', with: @income_statement.diluted_ni_available_to_com_stockholders
    fill_in 'Ebit', with: @income_statement.ebit
    fill_in 'Ebitda', with: @income_statement.ebitda
    fill_in 'Gross profit', with: @income_statement.gross_profit
    fill_in 'Interest expense', with: @income_statement.interest_expense
    fill_in 'Interest income', with: @income_statement.interest_income
    fill_in 'Net income common stockholders', with: @income_statement.net_income_common_stockholders
    fill_in 'Net income from continuing and discontinued operation',
            with: @income_statement.net_income_from_continuing_and_discontinued_operation
    fill_in 'Net income from continuing operation net minority interest',
            with: @income_statement.net_income_from_continuing_operation_net_minority_interest
    fill_in 'Net interest income', with: @income_statement.net_interest_income
    fill_in 'Net non operating interest income expense',
            with: @income_statement.net_non_operating_interest_income_expense
    fill_in 'Normalized ebitda', with: @income_statement.normalized_ebitda
    fill_in 'Normalized income', with: @income_statement.normalized_income
    fill_in 'Operating expense', with: @income_statement.operating_expense
    fill_in 'Operating income', with: @income_statement.operating_income
    fill_in 'Other income expense', with: @income_statement.other_income_expense
    fill_in 'Period', with: @income_statement.period
    fill_in 'Pretax income', with: @income_statement.pretax_income
    fill_in 'Reconciled cost of revenue', with: @income_statement.reconciled_cost_of_revenue
    fill_in 'Reconciled depreciation', with: @income_statement.reconciled_depreciation
    fill_in 'Tax effect of unusual items', with: @income_statement.tax_effect_of_unusual_items
    fill_in 'Tax provision', with: @income_statement.tax_provision
    fill_in 'Tax rate for calcs', with: @income_statement.tax_rate_for_calcs
    fill_in 'Total expenses', with: @income_statement.total_expenses
    fill_in 'Total operating income as reported', with: @income_statement.total_operating_income_as_reported
    fill_in 'Total revenue', with: @income_statement.total_revenue
    click_on 'Update Income statement'

    assert_text 'Income statement was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Income statement' do
    visit income_statements_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Income statement was successfully destroyed'
  end
end
