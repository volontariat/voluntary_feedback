Volontariat.CommunitiesController = Volontariat.Controller.extend(Volontariat.PaginationController, Volontariat.CommunityPersistence,
  paginationRoute: 'communities'
  
  anyItems: (-> @get('content.length') > 0).property('content')
)