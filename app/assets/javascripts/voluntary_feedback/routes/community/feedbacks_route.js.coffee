Volontariat.CommunityFeedbacksRoute = Ember.Route.extend
  controllerName: 'community.feedbacks'
  
  model: (params) ->
    feedbackType = @get('routeName').split('.')[1]
    @controllerFor('community.feedbacks').set 'feedbackType', feedbackType.singularize().capitalize()
    @controllerFor('community.feedbacks').set 'paginationRoute', "community.#{feedbackType}"
    @controllerFor('community.feedbacks').set 'page', parseInt(params.page)
    @controllerFor('community.feedbacks').set 'communitySlug', @modelFor('community').slug
    
    if feedbackType == 'feedbacks'
      @store.query 'feedback', community_slug: @modelFor('community').slug, page: params.page
    else
      @store.query 'feedback', community_slug: @modelFor('community').slug, feedback_type: feedbackType.singularize().capitalize(), page: params.page
      
  setupController: (controller, model) ->
    controller.send('goToPageWithoutRedirect', controller.get('page'))
    controller.set('model', model)
    
  renderTemplate: ->
    @render 'community/feedbacks'  
    
Volontariat.CommunityProblemsRoute = Volontariat.CommunityFeedbacksRoute.extend()
Volontariat.CommunityQuestionsRoute = Volontariat.CommunityFeedbacksRoute.extend()
Volontariat.CommunityIdeasRoute = Volontariat.CommunityFeedbacksRoute.extend()
Volontariat.CommunityPraisesRoute = Volontariat.CommunityFeedbacksRoute.extend()
Volontariat.CommunityAnnouncementsRoute = Volontariat.CommunityFeedbacksRoute.extend()
