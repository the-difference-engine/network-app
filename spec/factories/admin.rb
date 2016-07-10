FactoryGirl.define do 
  factory :admin do 
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    email Faker::Internet.email
    password "password"

    factory :invalid_admin do 
      first_name nil
    end
  end
end