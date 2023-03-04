FactoryBot.define do
   factory :collection do
    title {Faker::Educator.course_name} 
    desc {Faker::Lorem.paragraph} 
    image {Faker::LoremFlickr.image} 
    author
   end
end