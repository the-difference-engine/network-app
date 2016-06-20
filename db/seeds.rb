# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times do 
  Employer.create!(
    name: Faker::Company.name,
    image: Faker::Avatar.image,
    description: Faker::Hipster.sentence,
    rep_first_name: Faker::Name.first_name,
    rep_last_name: Faker::Name.last_name,
    rep_phone: Faker::PhoneNumber.cell_phone,
    rep_email: Faker::Internet.email,
    website: Faker::Internet.url,
    city: Faker::Address.city,
    state: Faker::Address.state_abbr,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
end