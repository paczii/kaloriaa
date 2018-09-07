json.array!(@stocks) do |stock|
  json.extract! stock, :id, :product_id, :store_id, :stock
  json.url stock_url(stock, format: :json)
end
