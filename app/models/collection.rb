class Collection < ApplicationRecord
    has_many :collections_courses
    # has_many :courses, through: :collections_courses

    has_many :bookmark_collections
    # has_many :users, through: :bookmark_collections
end
