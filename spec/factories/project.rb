FactoryGirl.define do 
  factory :project do 
    name Faker::Hipster.word
    description Faker::Hipster.sentence
    capstone true
    client_work false
    github Faker::Internet.url
    website Faker::Internet.url
    screencast Faker::Internet.url
    student_id rand(1..5)

    factory :invalid_project do 
      name nil
    end
  end
end