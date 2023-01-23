class AddColumnImageToCollections < ActiveRecord::Migration[7.0]
  def change
    add_column :collections, :image, :text
  end
end
