class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :content
      t.integer :user_id
      t.integer :owner_id

      t.timestamps
    end

	add_index :stories, :user_id
	add_index :stories, :created_at
	add_index :stories, :owner_id
  end
end
