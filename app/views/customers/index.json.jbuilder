json.array!(@customers) do |customer|
  json.extract! customer, :id, :user_id, :name, :city, :street, :zip, :costmodel, :favorites, :workcity, :workstreet, :workzip
  json.url customer_url(customer, format: :json)
end
