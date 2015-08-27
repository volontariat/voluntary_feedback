class Community < ActiveRecord::Base
  extend FriendlyId
  
  belongs_to :organization
  
  has_many :feedbacks
  
  validates :organization_id, presence: true
  validates :name, presence: true, uniqueness: true
  
  friendly_id :name, use: :slugged
  
  attr_accessible :organization_id, :name, :text
end