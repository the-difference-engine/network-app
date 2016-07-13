FactoryGirl.define do 
  factory :follow_up_list do 
    name Faker::Hipster.word
    employer_id rand(1..5)

    factory :invalid_follow_up_list do 
      name nil
    end
  end
end