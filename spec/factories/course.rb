FactoryBot.define do
    factory :course do
        # each user is assigned an id from 1-20
        title {Faker::Book.title}
        desc {Faker::Lorem.paragraph}
        author 
    end
  end