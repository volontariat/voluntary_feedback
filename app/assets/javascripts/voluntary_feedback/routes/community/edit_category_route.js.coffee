Volontariat.CommunityEditCategoryRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('community.edit_category').set 'communitySlug', @modelFor('community').slug
    @controllerFor('community.edit_category').set 'categorySlug', params.category_slug
    
    Ember.$.getJSON("/api/v1/community_categories/#{params.category_slug}?community_slug=#{@modelFor('community').slug}").then (json) =>
      @controllerFor('community.edit_category').set 'name', json.community_category.name
      
      json.community_category