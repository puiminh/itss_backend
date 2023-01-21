class Collection < ApplicationRecord
    has_many :collections_courses
    has_many :courses, through: :collections_courses
end
