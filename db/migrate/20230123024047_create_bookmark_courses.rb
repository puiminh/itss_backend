class CreateBookmarkCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmark_courses do |t|
      t.belongs_to :users
      t.belongs_to :courses
      t.timestamps
    end
  end
end
