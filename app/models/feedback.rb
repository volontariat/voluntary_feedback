class Feedback < ActiveRecord::Base
  include Likeable
  extend FriendlyId
  
  belongs_to :community
  belongs_to :user
  
  has_many :community_category_feedbacks
  has_many :categories, class_name: 'CommunityCategory', through: :community_category_feedbacks
  has_many :replies
  
  scope :for_category, ->(community_id, category_slug) do
    category_id = Community.find(community_id).categories.friendly.find(category_slug).id
    joins(:community_category_feedbacks).where('community_category_feedbacks.category_id = ?', category_id)
  end
  
  validates :community_id, presence: true
  validates :name, presence: true, uniqueness: { scope: :community_id }
  validates :text, presence: true
  validates :user_id, presence: true
  
  friendly_id :name, use: :scoped, scope: :community
  
  attr_accessible :community_id, :feedback_type, :name, :text, :mood_type, :mood_text
  
  attr_accessor :positive
end