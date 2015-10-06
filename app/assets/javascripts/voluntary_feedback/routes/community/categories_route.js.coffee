Volontariat.CommunityCategoriesRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('community.categories').set 'communitySlug', @modelFor('community').slug
    @controllerFor('community.categories').set 'page', parseInt(params.page)

    @store.query('community_category', community_slug: @modelFor('community').slug, page: params.page).then (result) =>
      @controllerFor('community.categories').set 'metadata', result.get('meta')
      result
    
  setupController: (controller, model) ->
    controller.send('goToPageWithoutRedirect', controller.get('page'))
    controller.set('model', model)