class Progress < ApplicationRecord
    belongs_to :user
    belongs_to :course
    belongs_to :vocabulary
end
