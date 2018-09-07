json.array!(@orders) do |order|
  json.extract! order, :id, :customer_id, :method, :day, :timewindow, :products, :neededboxes, :neededcoolingboxes, :neededfreezingboxes, :allocatedstore, :allocateddriver, :estimatedtime, :status
  json.url order_url(order, format: :json)
end
