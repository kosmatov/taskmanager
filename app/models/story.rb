class Story < ActiveRecord::Base
  attr_accessible :content, :owner_id, :state_event

  belongs_to :requester, class_name: :User
  belongs_to :owner, class_name: :User

  has_many :comments

  validates :content, :presence => true, :length => { :maximum => 255 }
  validates :owner, :presence => true

  state_machine :initial => :new do
    event :starting do
      transition any => :started
    end

    event :finishing do
      transition :started => :finished
    end

    event :accepting do
      transition :finished => :accepted
    end

    event :rejecting do
      transition :finished => :rejected
    end
  end
end
