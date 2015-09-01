Volontariat.CommunityNewFeedbackRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('community.new_feedback').set 'communitySlug', @modelFor('community').slug
    
    Ember.$.getJSON(
      "/api/v1/community_categories.json?community_slug=#{@modelFor('community').slug}"
    ).then (json) =>
      @controllerFor('community.new_feedback').set 'categories', json.community_categories