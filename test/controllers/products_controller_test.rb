# frozen_string_literal: true

require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test 'should get index' do
    get products_url
    assert_response :success
  end

  test 'should get new' do
    get new_product_url
    assert_response :success
  end

  test 'should create product' do
    assert_difference('Product.count') do
      post products_url,
           params: { product: { isin: @product.isin, mean_target_price: @product.mean_target_price, name: @product.name,
                                number_of_analysts: @product.number_of_analysts, recommendations: @product.recommendations, ticker: @product.ticker } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test 'should show product' do
    get product_url(@product)
    assert_response :success
  end

  test 'should get edit' do
    get edit_product_url(@product)
    assert_response :success
  end

  test 'should update product' do
    patch product_url(@product),
          params: { product: { isin: @product.isin, mean_target_price: @product.mean_target_price, name: @product.name,
                               number_of_analysts: @product.number_of_analysts, recommendations: @product.recommendations, ticker: @product.ticker } }
    assert_redirected_to product_url(@product)
  end

  test 'should destroy product' do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
