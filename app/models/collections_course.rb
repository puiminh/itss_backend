class CollectionsCourse < ApplicationRecord
    belongs_to :course
    belongs_to :collection
  end