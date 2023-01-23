class CreateBookmarkCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmark_courses do |t|
      t.belongs_to :user
      t.belongs_to :course
      t.timestamps
    end
  end
end
