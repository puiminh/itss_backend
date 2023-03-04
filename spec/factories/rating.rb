FactoryBot.define do
    factory :rating do
        star {Faker::Number.within(range: 1..5)} 
        course 
        user
    end
 end

