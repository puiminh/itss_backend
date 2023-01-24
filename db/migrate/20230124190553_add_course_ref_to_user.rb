class AddCourseRefToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :courses, :author, index: true, foreign_key: { to_table: :users }
  end
end
