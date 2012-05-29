class RemoveUserFromStory < ActiveRecord::Migration
  def up
    remove_column :stories, :user_id
  end

  def down
    add_column :stories, :user_id, :integer
  end
end
