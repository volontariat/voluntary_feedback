Volontariat.CommunityRoute = Ember.Route.extend
  model: (params) ->
    Ember.$.getJSON("/api/v1/communities/#{params.slug}").then (json) =>
      json.community