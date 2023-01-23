class CreateBookmarkCollections < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmark_collections do |t|
      t.belongs_to :user
      t.belongs_to :collection
      t.timestamps
    end
  end
end
