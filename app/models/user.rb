class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :courses, foreign_key: :author_id
  has_many :collections, foreign_key: :author_id

  # author: linnh
  # association
  has_many :comments
  # has_many :courses, through: :comments

  has_many :ratings
  # has_many :courses, through: :rating
  
  has_many :bookmark_collections
  # has_many :collections, through: :bookmark_collections

  has_many :bookmark_courses
  # has_many :courses, through: :bookmark_courses

  has_many :progresses
  # has_many :vocabularies, through: :progresses
  # has_many :courses, through: :progresses

end
