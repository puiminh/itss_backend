FactoryBot.define do
    factory :course do
        title {Faker::Book.title}
        desc {Faker::Lorem.paragraph}
        author 
    end
  end