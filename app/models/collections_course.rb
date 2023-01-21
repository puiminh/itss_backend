class Appointment < ApplicationRecord
    belongs_to :courses
    belongs_to :collections
  end