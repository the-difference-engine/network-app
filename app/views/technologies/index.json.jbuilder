json.array!(@technologies) do |technology|
  json.extract! technology, :id, :name
  json.url technology_url(technology, format: :json)
  json.students technology.students.each do |student|
    json.id student.id
    json.first_name student.first_name
    json.last_name student.last_name
    json.full_name student.full_name
    json.email student.email
    json.city student.city
    json.current_city student.current_city
    json.current_state student.current_state
    json.current_location student.current_location
    json.grad_date student.grad_date
    json.current_industry student.current_industry
    json.skill_1 student.skill_1
    json.skill_2 student.skill_2
    json.skill_3 student.skill_3
    json.interest_1 student.interest_1
    json.interest_2 student.interest_2
    json.interest_3 student.interest_3
    json.interview_1 student.interview_1
    json.interview_2 student.interview_2
    json.interview_3 student.interview_3
    json.github student.github
    json.blog student.blog
    json.linked_in student.linked_in
    json.quote student.quote
    json.seeking_employment student.seeking_employment
    json.active student.active
    json.about_me student.about_me
    json.role student.class.name
    json.avatar student.avatar
    json.skills? student.skills?
  end
end
