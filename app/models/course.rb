class Course < ApplicationRecord
    belongs_to :author, class_name: 'User'
    # 1-n 
    has_many :vocabularies, :dependent => :delete_all

    # n-n through collections_courses -> it's dump name by minh captain
    has_many :collections_courses, :dependent => :delete_all
    # has_many :collections, through: :collections_courses

    has_many :comments, :dependent => :delete_all
    # has_many :users, through: :comments

    has_many :ratings, :dependent => :delete_all
    # has_many :users, through: :ratings

    has_many :progresses, :dependent => :delete_all
    # has_many :vocabularies, through: :progresses
    # has_many :users, through: :progresses

    has_many :bookmark_courses, :dependent => :delete_all
    # has_many :users, through: :bookmark_courses
end
