class AddRequesterToStory < ActiveRecord::Migration
  def change
    add_column :stories, :requester_id, :integer
  end
end
