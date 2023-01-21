class AddUniqToCommentTableAndCollectionCourseTable < ActiveRecord::Migration[7.0]
  def change
    add_index :comments, [:users_id, :courses_id], unique: true
    add_index :collections_courses, [:collections_id, :courses_id], unique: true
  end
end
