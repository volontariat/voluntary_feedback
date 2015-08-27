Volontariat.CommunityFeedbackRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('community.feedback').set 'communitySlug', @modelFor('community').slug
    
    Ember.$.getJSON("/api/v1/feedbacks/#{params.feedback_slug}?community_slug=#{@modelFor('community').slug}").then (json) =>
      json.feedback