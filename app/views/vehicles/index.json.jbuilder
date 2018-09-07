json.array!(@vehicles) do |vehicle|
  json.extract! vehicle, :id, :name, :range, :emissions, :speed, :boxcapacity, :coolingboxcapacity, :freezingboxcapacity, :capacity
  json.url vehicle_url(vehicle, format: :json)
end
