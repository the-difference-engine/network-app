json.array!(@cohort_cities) do |cohort_city|
  json.extract! cohort_city, :id, :name
  json.url cohort_city_url(cohort_city, format: :json)
end
