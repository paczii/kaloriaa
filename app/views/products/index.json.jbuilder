json.array!(@products) do |product|
  json.extract! product, :id, :name, :brand, :price, :discountprice, :description, :weight, :ingredients, :size, :sqm, :vegan, :bio, :picture, :cool, :freeze, :durability, :category
  json.url product_url(product, format: :json)
end
