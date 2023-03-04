FactoryBot.define do
    factory :user, aliases: [:author] do
        # each user is assigned an id from 1-20
        first_name {Faker::Name.first_name}
        last_name {Faker::Name.last_name}
        avatar {Faker::Avatar.image}
        email {Faker::Internet.email}
        # issue each user the same password
        password {"123456"}
        password_confirmation {"123456"}
        user_name {Faker::Internet.username}
        # a user can have only one of these roles
        role {Faker::Number.within(range: 0..1)}
    end
  end