class Reply < ActiveRecord::Base
  include Likeable
  
  belongs_to :feedback
  belongs_to :user
  belongs_to :reply
  
  has_many :replies
  
  validates :user_id, presence: true
  validates :text, presence: true
  
  attr_accessible :text
  
  attr_accessor :positive
end