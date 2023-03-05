# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# generate 20 users
(1..100).each do |id|
    User.create!(
        # each user is assigned an id from 1-20
        first_name: Faker::Name.first_name ,
        last_name: Faker::Name.last_name,
        avatar: Faker::Avatar.image,
        email: Faker::Internet.email,
        # issue each user the same password
        password: "123456", 
        password_confirmation: "123456",
        user_name:Faker::Internet.username,
        # a user can have only one of these roles
        role: Faker::Number.within(range: 0..1)
    )
end


# # Course
(1..40).each do |id|
    Course.create!(
        # each user is assigned an id from 1-20
        title: Faker::Book.title,
        desc: Faker::Lorem.paragraph,
        author: User.find(Faker::Number.within(range: 1..20))  
    )
end

# Vocabulary
(1..500).each do |id|
    Vocabulary.create!(
        # each user is assigned an id from 1-20
        word: Faker::Verb.base,
        define: Faker::Lorem.paragraph,
        link: Faker::LoremFlickr.image,
        kind: 1,
        course: Course.find(Faker::Number.within(range: 1..40))
    )
end

# # Comment
(1..20).each do |id|
    Comment.create!(
        content: Faker::Lorem.sentence,
        course: Course.find(Faker::Number.within(range: 1..40)),
        user: User.find(Faker::Number.within(range: 1..100))
    )
end

# # Rating
(1..15).each do |id|
    Rating.create!(
        # each user is assigned an id from 1-20
        star: Faker::Number.within(range: 1..5),
        course: Course.find(Faker::Number.within(range: 1..40)),
        user: User.find(Faker::Number.within(range: 1..100))
    )
end


#  Progress
(1..500).each do |id|
    Progress.create!(
        # each user is assigned an id from 1-20
        point: Faker::Number.within(range: 1..10),
        course: Course.find(Faker::Number.within(range: 1..40)),
        user: User.find(Faker::Number.within(range: 1..100)),
        vocabulary: Vocabulary.find(Faker::Number.within(range: 1..500))
    )
end



# #  Collection
(1..15).each do |id|
    Collection.create!(
        # each user is assigned an id from 1-20
        title: Faker::Educator.course_name,
        desc: Faker::Lorem.paragraph,
        image: Faker::LoremFlickr.image,
        author: User.find(Faker::Number.within(range: 1..20))
    )
end

# #  Collections course
(1..15).each do |id|
    CollectionsCourse.create!(
        # each user is assigned an id from 1-20
        course: Course.find(Faker::Number.within(range: 1..40)),
        collection: Collection.find(Faker::Number.within(range: 1..15))
    )
end

# #  Bookmark Course
(1..15).each do |id|
    BookmarkCourse.create!(
        # each user is assigned an id from 1-20
        course: Course.find(Faker::Number.within(range: 1..40)),
        user: User.find(Faker::Number.within(range: 1..10))
    )
end

# #  Bookmark Collection
(1..15).each do |id|
    BookmarkCollection.create!(
        # each user is assigned an id from 1-20
        collection: Collection.find(Faker::Number.within(range: 1..15)),
        user: User.find(Faker::Number.within(range: 1..50))
    )
end

#Notice
Notice.create!(
    message: "this is message for testing",
    user_id: 1,
    from: 2
)