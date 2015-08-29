class ReplySerializer < ActiveModel::Serializer
  attributes :id, :reply_id, :user_id, :user_slug, :user_name, :text, :positive, :likes_count, :dislikes_count, :created_at, :replies

  def user_slug
    object.user.try(:slug)
  end

  def user_name
    object.user.try(:name)
  end
  
  def replies
    if object.reply_id
      []
    else
      object.replies.map{|r| ReplySerializer.new(r)}
    end
  end
end