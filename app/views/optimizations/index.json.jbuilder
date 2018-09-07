json.array!(@optimizations) do |optimization|
  json.extract! optimization, :id, :optimizationtype, :orders, :drivers, :totalboxes, :totalcoolingboxes, :totalfreezingboxes, :allocation, :routes, :totaltraveltime, :totaldistance, :turnover, :productcosts, :worktimecosts, :drivingcosts, :totalcosts, :profit, :useddrivers, :usedstores
  json.url optimization_url(optimization, format: :json)
end
