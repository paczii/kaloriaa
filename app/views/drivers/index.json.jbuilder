json.array!(@drivers) do |driver|
  json.extract! driver, :id, :store_id, :vehicle, :route, :totaltraveltime, :totalemissions, :totaldistance, :boxes, :coolingboxes, :freezingboxes
  json.url driver_url(driver, format: :json)
end
