json.array!(@directions) do |direction|
  json.extract! direction, :id, :optimization_id, :from, :to, :by
  json.url direction_url(direction, format: :json)
end
