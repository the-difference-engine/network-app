json.array!(@salary_ranges) do |salary_range|
  json.extract! salary_range, :id, :salary_range
  json.url salary_range_url(salary_range, format: :json)
end
