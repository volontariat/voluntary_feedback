class Feedback < ActiveRecord::Base
  include Likeable
  extend FriendlyId
  
  belongs_to :community
  belongs_to :user
  
  validates :community_id, presence: true
  validates :name, presence: true, uniqueness: { scope: :community_id }
  validates :text, presence: true
  validates :user_id, presence: true
  
  friendly_id :name, use: :scoped, scope: :community
  
  attr_accessible :community_id, :feedback_type, :name, :text, :mood_type, :mood_text
end