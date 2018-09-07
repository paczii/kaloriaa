json.array!(@carts) do |cart|
  json.extract! cart, :id, :items, :customer_id, :numberofitems, :products, :price
  json.url cart_url(cart, format: :json)
end
