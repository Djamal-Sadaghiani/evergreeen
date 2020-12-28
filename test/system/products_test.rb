require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  setup do
    @product = products(:one)
  end

  test "visiting the index" do
    visit products_url
    assert_selector "h1", text: "Products"
  end

  test "creating a Product" do
    visit products_url
    click_on "New Product"

    fill_in "Isin", with: @product.isin
    fill_in "Mean target price", with: @product.mean_target_price
    fill_in "Name", with: @product.name
    fill_in "Number of analysts", with: @product.number_of_analysts
    fill_in "Recommendations", with: @product.recommendations
    fill_in "Ticker", with: @product.ticker
    click_on "Create Product"

    assert_text "Product was successfully created"
    click_on "Back"
  end

  test "updating a Product" do
    visit products_url
    click_on "Edit", match: :first

    fill_in "Isin", with: @product.isin
    fill_in "Mean target price", with: @product.mean_target_price
    fill_in "Name", with: @product.name
    fill_in "Number of analysts", with: @product.number_of_analysts
    fill_in "Recommendations", with: @product.recommendations
    fill_in "Ticker", with: @product.ticker
    click_on "Update Product"

    assert_text "Product was successfully updated"
    click_on "Back"
  end

  test "destroying a Product" do
    visit products_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Product was successfully destroyed"
  end
end
