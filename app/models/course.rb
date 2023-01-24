class Course < ApplicationRecord
    belongs_to :author, class_name: 'User'
    # 1-n 
    has_many :vocabularies

    # n-n through collections_courses -> it's dump name by minh captain
    has_many :collections_courses
    # has_many :collections, through: :collections_courses

    has_many :comments
    # has_many :users, through: :comments

    has_many :ratings
    # has_many :users, through: :ratings

    has_many :progresses
    # has_many :vocabularies, through: :progresses
    # has_many :users, through: :progresses

    has_many :bookmark_collections
    # has_many :users, through: :bookmark_collections

    has_many :bookmark_courses
    # has_many :users, through: :bookmark_courses
end
