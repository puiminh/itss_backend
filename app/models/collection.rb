class Collection < ApplicationRecord
    has_many :collections_courses, :dependent => :delete_all
    # has_many :courses, through: :collections_courses

    has_many :bookmark_collections, :dependent => :delete_all
    # has_many :users, through: :bookmark_collections

    belongs_to :author, class_name: 'User'
end
