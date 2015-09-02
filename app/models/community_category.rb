class CommunityCategory < ActiveRecord::Base
  extend FriendlyId
  
  belongs_to :community
  
  has_many :community_category_feedbacks, source: 'category'
  has_many :feedbacks, through: :community_category_feedbacks
  
  validates :community_id, presence: true
  validates :name, presence: true, uniqueness: { scope: :community_id }
  
  friendly_id :name, use: :scoped, scope: :community
  
  attr_accessible :name
  
  private
  
  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end