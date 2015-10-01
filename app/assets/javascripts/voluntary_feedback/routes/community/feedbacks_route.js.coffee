Volontariat.CommunityFeedbacksRoute = Ember.Route.extend
  controllerName: 'community.feedbacks'
  
  model: (params) ->
    if @get('routeName').split('.').length == 3
      feedbackType = @get('routeName').split('.')[2]
    else
      feedbackType = @get('routeName').split('.')[1]
      
    @controllerFor('community.feedbacks').set 'feedbackType', feedbackType.singularize().capitalize()
    @controllerFor('community.feedbacks').set 'paginationRoute', "community.#{feedbackType}"
    @controllerFor('community.feedbacks').set 'page', parseInt(params.page)
    @controllerFor('community.feedbacks').set 'communitySlug', @modelFor('community').slug
    
    if @get('routeName').split('.').length == 3
      categorySlug = if @modelFor('community.category') then @modelFor('community.category').slug else null
      @controllerFor('community.feedbacks').set 'categorySlug', categorySlug
    else
      @controllerFor('community.feedbacks').set 'categorySlug', null
      
    if feedbackType == 'feedbacks'
      @store.query 'feedback', community_slug: @modelFor('community').slug, category_slug: categorySlug, page: params.page
    else
      @store.query 'feedback', community_slug: @modelFor('community').slug, category_slug: categorySlug, feedback_type: feedbackType.singularize().capitalize(), page: params.page
      
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

Volontariat.CommunityCategoryFeedbacksRoute = Volontariat.CommunityFeedbacksRoute.extend()
Volontariat.CommunityCategoryProblemsRoute = Volontariat.CommunityFeedbacksRoute.extend()
Volontariat.CommunityCategoryQuestionsRoute = Volontariat.CommunityFeedbacksRoute.extend()
Volontariat.CommunityCategoryIdeasRoute = Volontariat.CommunityFeedbacksRoute.extend()
Volontariat.CommunityCategoryPraisesRoute = Volontariat.CommunityFeedbacksRoute.extend()
Volontariat.CommunityCategoryAnnouncementsRoute = Volontariat.CommunityFeedbacksRoute.extend()
