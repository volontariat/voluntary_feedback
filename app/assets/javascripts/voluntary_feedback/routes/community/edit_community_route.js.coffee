Volontariat.EditCommunityRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('edit_community').set 'slug', params.slug
    
    if Volontariat.User.current()
      Ember.$.getJSON(
        "/api/v1/users/#{Volontariat.User.current().id}/organizations.json"
      ).then (json) =>
        @controllerFor('edit_community').set 'organizations', json.organizations
    
    Ember.$.getJSON("/api/v1/communities/#{params.slug}").then (json) =>
      $('#community_organization_id').val(json.community.organization_id)
      @controllerFor('edit_community').set 'name', json.community.name
      @controllerFor('edit_community').set 'text', json.community.text
      
      json.brainstorming