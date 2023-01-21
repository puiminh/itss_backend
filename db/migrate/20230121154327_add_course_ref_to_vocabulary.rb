class AddCourseRefToVocabulary < ActiveRecord::Migration[7.0]
  def change
    add_reference :vocabularies, :courses, index: true, foreign_key: true
  end
end
