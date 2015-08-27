Volontariat.CommunityFeedbacksController = Volontariat.Controller.extend(Volontariat.PaginationController, Volontariat.FeedbackPersistence,
  paginationResource: 'feedback'
  
  anyItems: (-> @get('content.length') > 0).property('content')
)