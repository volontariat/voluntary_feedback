Volontariat.CommunityCategoryRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('community.category').set 'communitySlug', @modelFor('community').slug
    @controllerFor('community.category').set 'slug', params.category_slug
    
    Ember.$.getJSON("/api/v1/community_categories/#{params.category_slug}?community_slug=#{@modelFor('community').slug}").then (json) =>
      json.community_category