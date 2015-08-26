Volontariat.NewCommunityRoute = Ember.Route.extend
  model: (params) ->
    if Volontariat.User.current()
      Ember.$.getJSON(
        "/api/v1/users/#{Volontariat.User.current().id}/organizations.json"
      ).then (json) =>
        @controllerFor('new_community').set 'organizations', json.organizations