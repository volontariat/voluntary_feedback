class FeedbackSerializer < ActiveModel::Serializer
  attributes :id, :feedback_type, :user_id, :user_slug, :user_name, :name, :slug, :text, :mood_type, :mood_text, :likes_count, :dislikes_count, :created_at

  def user_slug
    object.user.try(:slug)
  end

  def user_name
    object.user.try(:name)
  end
end