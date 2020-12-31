json.extract! product, :id, :isin, :name, :long_name, :equity_type, :recommendations, :mean_target_price, :number_of_analysts, :ticker, :created_at, :updated_at
json.url product_url(product, format: :json)
