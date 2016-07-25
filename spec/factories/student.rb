FactoryGirl.define do 
  factory :student do 
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    city Faker::Address.city
    current_city Faker::Address.city
    current_state Faker::Address.state_abbr
    current_industry Faker::Internet.domain_word
    grad_date "2015-03-25"
    about_me Faker::Hacker.say_something_smart
    skill_1 Faker::Hacker.abbreviation
    skill_2 Faker::Hacker.abbreviation
    skill_3 Faker::Hacker.abbreviation
    interest_1 Faker::Hacker.ingverb
    interest_2 Faker::Hacker.ingverb
    interest_3 Faker::Hacker.ingverb
    interview_1 Faker::Hacker.say_something_smart
    interview_2 Faker::Hacker.say_something_smart
    interview_3 Faker::Hacker.say_something_smart
    github Faker::Internet.url
    blog Faker::Internet.url
    linked_in Faker::Internet.url
    quote Faker::Hacker.say_something_smart
    seeking_employment true
    resume Faker::Internet.url
    active true
    email Faker::Internet.email
    password "password"

    factory :invalid_student do 
      email nil
    end

    factory :login_student do 
      email "student_login@gmail.com"
    end
  end
end