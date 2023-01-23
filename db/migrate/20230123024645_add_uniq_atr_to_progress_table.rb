class AddUniqAtrToProgressTable < ActiveRecord::Migration[7.0]
  def change
    add_index :progresses, [:user_id, :course_id, :vocabulary_id], unique: true
  end
end
