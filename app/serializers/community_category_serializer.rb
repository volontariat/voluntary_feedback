class CommunityCategorySerializer < ActiveModel::Serializer
  attributes :id, :community_id, :name, :slug, :feedbacks_count
end