class Community < ActiveRecord::Base
  extend FriendlyId
  
  belongs_to :organization
  
  has_many :categories, class_name: 'CommunityCategory', dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  
  validates :organization_id, presence: true
  validates :name, presence: true, uniqueness: true
  
  friendly_id :name, use: :slugged
  
  attr_accessible :organization_id, :name, :text
  
  private
  
  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end