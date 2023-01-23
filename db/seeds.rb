# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# generate 20 users
(1..20).each do |id|
    User.create!(
        # each user is assigned an id from 1-20
        id: id, 
        first_name: Faker::Name.first_name ,
        last_name: Faker::Name.last_name,
        avatar: Faker::Avatar.image,
        email: Faker::Internet.email,
        # issue each user the same password
        password: "123456", 
        password_confirmation: "123456",
        # a user can have only one of these roles
        role: Faker::Number.within(range: 0..1)
    )
end


# Course
(1..10).each do |id|
    Course.create!(
        # each user is assigned an id from 1-20
        id: id, 
        title: Faker::Book.title,
        desc: Faker::Lorem.paragraph    
    )
end

# Vocabulary
(1..10).each do |id|
    Vocabulary.create!(
        # each user is assigned an id from 1-20
        id: id, 
        word: Faker::Kpop.girl_groups,
        define: Faker::Lorem.paragraph,
        link: Faker::Internet.url,
        kind: Faker::Number.within(range: 0..5),
        course: Course.find(Faker::Number.within(range: 1..10))
    )
end

# Comment
(1..50).each do |id|
    Comment.create!(
        # each user is assigned an id from 1-20
        id: id, 
        content: Faker::Lorem.sentence,
        course: Course.find(Faker::Number.within(range: 1..10)),
        user: User.find(Faker::Number.within(range: 1..20))
    )
end

# Rating
(1..15).each do |id|
    Rating.create!(
        # each user is assigned an id from 1-20
        id: id, 
        star: Faker::Number.within(range: 1..5),
        course: Course.find(Faker::Number.within(range: 1..10)),
        user: User.find(Faker::Number.within(range: 1..20))
    )
end


#  Progress
(1..15).each do |id|
    Progress.create!(
        # each user is assigned an id from 1-20
        id: id, 
        point: Faker::Number.within(range: 1..1000),
        course: Course.find(Faker::Number.within(range: 1..10)),
        user: User.find(Faker::Number.within(range: 1..20)),
        vocabulary: Vocabulary.find(Faker::Number.within(range: 1..10))
    )
end



#  Collection
(1..10).each do |id|
    Collection.create!(
        # each user is assigned an id from 1-20
        id: id, 
        title: Faker::Educator.course_name,
        desc: Faker::Lorem.paragraph,
        image: Faker::LoremFlickr.image
    )
end

#  Collections course
(1..15).each do |id|
    CollectionsCourse.create!(
        # each user is assigned an id from 1-20
        id: id, 
        course: Course.find(Faker::Number.within(range: 1..20)),
        collection: Collection.find(Faker::Number.within(range: 1..10))
    )
end

#  Bookmark Course
(1..15).each do |id|
    BookmarkCourse.create!(
        # each user is assigned an id from 1-20
        id: id, 
        course: Course.find(Faker::Number.within(range: 1..10)),
        user: User.find(Faker::Number.within(range: 1..10))
    )
end

#  Bookmark Collection
(1..15).each do |id|
    BookmarkCollection.create!(
        # each user is assigned an id from 1-20
        id: id, 
        collection: Collection.find(Faker::Number.within(range: 1..10)),
        user: User.find(Faker::Number.within(range: 1..10))
    )
end
