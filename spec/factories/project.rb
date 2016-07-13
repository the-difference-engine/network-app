FactoryGirl.define do 
  factory :project do 
    name Faker::Hipster.word
    description Faker::Hipster.sentence
    capstone true
    client_work false
    github Faker::Internet.url
    website Faker::Internet.url
    screencast Faker::Internet.url
    student_id [1,2,3,4,5].sample

    factory :invalid_project do 
      name nil
    end
  end
end