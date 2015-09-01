Volontariat.CommunityCategoriesController = Volontariat.Controller.extend(Volontariat.PaginationController, Volontariat.CommunityCategoryPersistence,
  paginationResource: 'community_category', paginationRoute: 'community.categories'
  
  anyItems: (-> @get('content.length') > 0).property('content')
)