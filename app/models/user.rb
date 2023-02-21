class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :courses, foreign_key: :author_id
  has_many :collections, foreign_key: :author_id

  has_many :notices
  has_many :notices, foreign_key: :from

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

  before_create do
    self.role = 0 if role.blank?
    self.avatar = 'https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png' if avatar.blank?
  end

  before_update do
    self.role = 0 if role.blank?
  end
end
