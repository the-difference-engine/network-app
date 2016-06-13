15.times do 
  Student.create!(
    email: Faker::Internet.email,
    password: "password",
    avatar: Faker::Company.logo,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    city: Faker::Address.city,
    industry: Faker::Company.profession,
    grad_date: "2016-03-25",
    skill_1: Faker::Hacker.ingverb,
    skill_2: Faker::Hacker.ingverb,
    skill_3: Faker::Hacker.ingverb,
    interest_1: Faker::Hacker.ingverb,
    interest_2: Faker::Hacker.ingverb,
    interest_3: Faker::Hacker.ingverb,
    interview_1: Faker::Hacker.say_something_smart,
    interview_2: Faker::Hacker.say_something_smart,
    interview_3: Faker::Hacker.say_something_smart,
    github: Faker::Internet.url,
    blog: Faker::Internet.url,
    quote: Faker::Company.catch_phrase,
    seeking_employment: random_boolean = [true, false].sample,
    resume: Faker::Internet.url,
    )
end

