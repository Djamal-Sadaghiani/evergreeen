# frozen_string_literal: true

require 'application_system_test_case'

class CompaniesTest < ApplicationSystemTestCase
  setup do
    @company = companies(:one)
  end

  test 'visiting the index' do
    visit companies_url
    assert_selector 'h1', text: 'Companies'
  end

  test 'creating a Company' do
    visit companies_url
    click_on 'New Company'

    fill_in 'Description', with: @company.description
    fill_in 'Employees', with: @company.employees
    fill_in 'Headquarter', with: @company.headquarter
    fill_in 'Industry', with: @company.industry
    fill_in 'Sector', with: @company.sector
    fill_in 'Shares outstanding', with: @company.shares_outstanding
    fill_in 'Uuid', with: @company.uuid
    click_on 'Create Company'

    assert_text 'Company was successfully created'
    click_on 'Back'
  end

  test 'updating a Company' do
    visit companies_url
    click_on 'Edit', match: :first

    fill_in 'Description', with: @company.description
    fill_in 'Employees', with: @company.employees
    fill_in 'Headquarter', with: @company.headquarter
    fill_in 'Industry', with: @company.industry
    fill_in 'Sector', with: @company.sector
    fill_in 'Shares outstanding', with: @company.shares_outstanding
    fill_in 'Uuid', with: @company.uuid
    click_on 'Update Company'

    assert_text 'Company was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Company' do
    visit companies_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Company was successfully destroyed'
  end
end
