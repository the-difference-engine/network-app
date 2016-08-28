json.id employer.id
json.name employer.name
json.email employer.email
json.city employer.city
json.state employer.state
json.description employer.description
json.website employer.website
json.rep_first_name employer.rep_first_name
json.rep_last_name employer.rep_last_name
json.rep_full_name employer.rep_full_name
json.rep_email employer.rep_email
json.rep_phone employer.rep_phone
json.hiring_timeline employer.hiring_timeline
json.number_of_positions employer.number_of_positions
json.company_size employer.company_size
json.active employer.active
json.role employer.class.name

json.follow_up_list employer.follow_up_list
json.students employer.follow_up_list.students
json.student_emails employer.student_email_records.each do |student_email_record|
  json.id student_email_record.id
  json.employer_id student_email_record.employer_id
  json.student_id student_email_record.student_id
  json.employer_name student_email_record.employer.name
  json.student_name student_email_record.student.full_name
end
