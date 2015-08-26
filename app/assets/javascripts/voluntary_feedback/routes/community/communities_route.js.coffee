Volontariat.CommunitiesRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('communities').set 'page', parseInt(params.page)

    @store.query 'community', page: params.page
    
  setupController: (controller, model) ->
    controller.send('goToPageWithoutRedirect', controller.get('page'))
    controller.set('model', model)