json.extract! trade, :id, :trade_uuid, :isin, :name, :time, :price, :amount, :created_at, :updated_at
json.url trade_url(trade, format: :json)
