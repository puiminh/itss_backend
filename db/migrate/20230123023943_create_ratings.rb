class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.integer :star
      t.belongs_to :users
      t.belongs_to :courses

      t.timestamps
    end
  end
end
