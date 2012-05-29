class AddStateToStory < ActiveRecord::Migration
  def change
    add_column :stories, :state, :string
  end
end
