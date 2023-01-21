class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.belongs_to :users
      t.belongs_to :courses

      t.timestamps
    end 
  end
end
