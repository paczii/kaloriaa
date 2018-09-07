json.array!(@compares) do |compare|
  json.extract! compare, :id, :number, :opt1, :opt2, :opt3, :opt4, :opt5
  json.url compare_url(compare, format: :json)
end
