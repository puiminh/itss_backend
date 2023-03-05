class Rating < ApplicationRecord

    after_save :nocti_to_user

    belongs_to :user
    belongs_to :course

end
