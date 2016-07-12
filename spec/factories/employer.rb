FactoryGirl.define do 
  factory :employer do 
    name Faker::Hipster.word
    description Faker::Hipster.sentence
    rep_first_name Faker::Name.first_name
    rep_last_name Faker::Name.last_name
    rep_phone Faker::PhoneNumber.cell_phone
    rep_email Faker::Internet.email
    website Faker::Internet.url
    city Faker::Address.city
    state Faker::Address.state_abbr
    email Faker::Internet.email
    password "password"

    after(:build) do |employer|
      employer.follow_up_list << FactoryGirl.build(:follow_up_list, employer: employer)
    end

    factory :invalid_employer do 
      name nil
    end

    factory :login_employer do 
      email "employer_login@gmail.com"
    end
  end
end