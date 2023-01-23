class AddCollectionCourseTable < ActiveRecord::Migration[7.0]
  def change
    create_table :collections_courses do |t|
    t.belongs_to :collection
    t.belongs_to :course

    t.timestamps
    end
  end
end
