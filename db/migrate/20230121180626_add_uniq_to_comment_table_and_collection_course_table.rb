class AddUniqToCommentTableAndCollectionCourseTable < ActiveRecord::Migration[7.0]
  def change
    add_index :collections_courses, [:collection_id, :course_id], unique: true
  end
end
