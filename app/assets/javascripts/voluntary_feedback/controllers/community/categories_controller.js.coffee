Volontariat.CommunityCategoriesController = Volontariat.Controller.extend(Volontariat.PaginationController, Volontariat.CommunityCategoryPersistence,
  paginationRoute: 'community.categories'
  
  anyItems: (-> @get('content.length') > 0).property('content')
)