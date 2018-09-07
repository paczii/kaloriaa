json.array!(@distances) do |distance|
  json.extract! distance, :id, :from_id, :to_id, :traveltime, :traveldistance
  json.url distance_url(distance, format: :json)
end
