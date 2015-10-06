Volontariat.CommunitiesRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('communities').set 'page', parseInt(params.page)

    @store.query('community', page: params.page).then (result) =>
      @controllerFor('communities').set 'metadata', result.get('meta')
      result
    
  setupController: (controller, model) ->
    controller.send('goToPageWithoutRedirect', controller.get('page'))
    controller.set('model', model)