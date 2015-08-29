class Reply < ActiveRecord::Base
  include Likeable
  
  belongs_to :feedback
  belongs_to :user
  
  validates :feedback_id, presence: true
  validates :user_id, presence: true
  validates :text, presence: true
  
  attr_accessible :text
end