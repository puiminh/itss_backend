class CreateBookmarkCollections < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmark_collections do |t|
      t.belongs_to :users
      t.belongs_to :collections
      t.timestamps
    end
  end
end
