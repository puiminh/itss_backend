class AddCollectionCourseTable < ActiveRecord::Migration[7.0]
  def change
    create_table :collections_courses do |t|
    t.belongs_to :collections
    t.belongs_to :courses

    t.timestamps
    end
  end
end
