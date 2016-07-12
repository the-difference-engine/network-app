FactoryGirl.define do 
  factory :follow_up_list do 
    name Faker::Hipster.word

    factory :invalid_follow_up_list do 
      name nil
    end
  end
end