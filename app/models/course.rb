class Course < ApplicationRecord
    # 1-n 
    has_many :vocabularies

    # n-n through collections_courses -> it's dump name by minh captain
    has_many :collections_courses
    has_many :collections, through: :collections_courses

    has_many :comments
    has_many :users, through: :comments
end
