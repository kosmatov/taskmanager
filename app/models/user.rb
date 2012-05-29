class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  validates_presence_of :password, on: :create
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, email: true

  has_many :stories_out, class_name: :Story, foreign_key: :requester_id, dependent: :destroy
  has_many :stories_in, class_name: :Story, foreign_key: :owner_id
end
