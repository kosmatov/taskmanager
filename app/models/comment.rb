class Comment < ActiveRecord::Base
  attr_accessible :content

  validates :content, :presence => true, :length => { :maximum => 255 }
  belongs_to :story
  belongs_to :user
end
