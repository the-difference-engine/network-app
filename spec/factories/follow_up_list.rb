FactoryGirl.define do 
  factory :follow_up_list do 
    name Faker::Hipster.word
    employer_id [1,2,3,4,5].sample

    factory :invalid_follow_up_list do 
      name nil
    end
  end
end