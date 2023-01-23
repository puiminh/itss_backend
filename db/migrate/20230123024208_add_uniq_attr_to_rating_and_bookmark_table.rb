class AddUniqAttrToRatingAndBookmarkTable < ActiveRecord::Migration[7.0]
  def change
    add_index :ratings, [:users_id, :courses_id], unique: true
    add_index :bookmark_courses, [:users_id, :courses_id], unique: true
    add_index :bookmark_collections, [:users_id, :collections_id], unique: true
  end
end
