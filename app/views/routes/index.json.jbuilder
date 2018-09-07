json.array!(@routes) do |route|
  json.extract! route, :id, :driver_id, :optimization_id, :day, :route, :traveltime, :traveldistance, :worktimecosts, :drivingcosts, :totalcosts, :totalprofit
  json.url route_url(route, format: :json)
end
