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
  validate :announcement_only_for_organization_owner, if: 'feedback_type == "Announcement"'
  
  friendly_id :name, use: :scoped, scope: :community
  
  attr_accessible :community_id, :feedback_type, :name, :text, :mood_type, :mood_text
  
  attr_accessor :positive
  
  def category_ids=(ids)
    categories.select{|c| !ids.map(&:to_i).include?(c.id)}.each do |category|
      categories.delete category
    end
    
    category_ids = categories.where('community_categories.id IN(?)', ids).map(&:id)
    
    ids.each do |category_id|
      next if category_ids.include? category_id.to_i
        
      categories << CommunityCategory.find(category_id)
    end
  end
  
  private
  
  def announcement_only_for_organization_owner
    unless community.organization.user_id == user_id
      errors[:base] << I18n.t('activerecord.errors.models.feedback.attributes.base.announcement_only_for_organization_owner')
    end
  end
  
  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end