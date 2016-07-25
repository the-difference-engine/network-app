FactoryGirl.define do 
  factory :admin do 
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    active true
    email Faker::Internet.email
    password "password"

    factory :invalid_admin do 
      first_name nil
    end

    factory :login_admin do 
      email "admin_login@gmail.com"
    end
  end
end