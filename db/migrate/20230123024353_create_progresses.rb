class CreateProgresses < ActiveRecord::Migration[7.0]
  def change
    create_table :progresses do |t|
      t.integer :point
      t.belongs_to :user
      t.belongs_to :course
      t.belongs_to :vocabulary
      t.timestamps
    end
  end
end
