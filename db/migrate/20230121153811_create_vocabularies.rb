class CreateVocabularies < ActiveRecord::Migration[7.0]
  def change
    create_table :vocabularies do |t|
      t.string :word
      t.text :define
      t.text :link
      t.integer :type

      t.timestamps
    end
  end
end
