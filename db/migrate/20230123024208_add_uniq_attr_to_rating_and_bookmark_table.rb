class AddUniqAttrToRatingAndBookmarkTable < ActiveRecord::Migration[7.0]
  def change
    add_index :ratings, [:user_id, :course_id], unique: true
    add_index :bookmark_courses, [:user_id, :course_id], unique: true
    add_index :bookmark_collections, [:user_id, :collection_id], unique: true
  end
end
