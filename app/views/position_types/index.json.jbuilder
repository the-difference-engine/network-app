json.array!(@position_types) do |position_type|
  json.extract! position_type, :id, :name
  json.url position_type_url(position_type, format: :json)
end
