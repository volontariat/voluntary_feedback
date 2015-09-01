Volontariat.CommunityNewCategoryRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('community.new_category').set 'communitySlug', @modelFor('community').slug