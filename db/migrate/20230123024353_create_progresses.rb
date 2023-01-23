class CreateProgresses < ActiveRecord::Migration[7.0]
  def change
    create_table :progresses do |t|
      t.integer :point
      t.belongs_to :users
      t.belongs_to :courses
      t.belongs_to :vocabularies
      t.timestamps
    end
  end
end
