class AddUniqAtrToProgressTable < ActiveRecord::Migration[7.0]
  def change
    add_index :progresses, [:users_id, :courses_id, :vocabularies_id], unique: true
  end
end
