class CommunitySerializer < ActiveModel::Serializer
  attributes :id, :organization_id, :organization_slug, :organization_name, :name, :slug, :text

  def organization_slug
    object.organization.try(:slug)
  end

  def organization_name
    object.organization.try(:name)
  end
end