class Notice < ApplicationRecord
  belongs_to :user
  belongs_to :from_user, class_name: "User", foreign_key: "from"
end
