Volontariat.CommunityNewFeedbackRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('community.new_feedback').set 'communitySlug', @modelFor('community').slug