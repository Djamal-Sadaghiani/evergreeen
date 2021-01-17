json.extract! event, :id, :type, :info, :date, :confirmed, :product_id, :created_at, :updated_at
json.url event_url(event, format: :json)
