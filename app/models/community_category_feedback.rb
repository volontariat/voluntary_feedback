class CommunityCategoryFeedback < ActiveRecord::Base
  belongs_to :category, class_name: 'CommunityCategory', counter_cache: 'feedbacks_count'
  belongs_to :feedback
  
  validates :category_id, presence: true
  validates :feedback_id, presence: true
end