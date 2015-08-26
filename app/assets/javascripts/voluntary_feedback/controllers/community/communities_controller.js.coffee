Volontariat.CommunitiesController = Volontariat.Controller.extend(Volontariat.PaginationController, Volontariat.CommunityPersistence,
  paginationResource: 'community', paginationRoute: 'communities'
  
  anyItems: (-> @get('content.length') > 0).property('content')
)