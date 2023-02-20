class CreateNotices < ActiveRecord::Migration[7.0]
  def change
    create_table :notices do |t|
      t.string :action
      t.string :data
      t.integer :seen
      t.text :message

      t.timestamps
    end
    add_reference :notices, :user, foreign_key: true
    add_column :notices, :from, :bigint
    add_foreign_key :notices, :users, column: :from
  end
end
