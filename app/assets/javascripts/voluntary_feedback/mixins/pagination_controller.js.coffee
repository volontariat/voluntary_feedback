Volontariat.PaginationController = Em.Mixin.create
  pages: [], totalPages: 1, page: 1, metadata: null
  
  showFirstPageLink: (-> @get('page') != 1).property('page')
  showPreviousPageLink: (-> @get('page') - 1 > 0).property('page')
  previousPage: (-> @get('page') - 1).property('page')
  showNextPageLink: (-> @get('page') + 1 <= @get('totalPages')).property('page')
  nextPage: (-> @get('page') + 1).property('page')
  showLastPageLink: (-> @get('page') != @get('totalPages')).property('page')

  _goToPage: (page) ->
    page = parseInt(page)
    @set 'page', page
      
    if @get('metadata')
      @set 'totalPages', @get('metadata').pagination.total_pages
    else if @store.metadataFor(@get('paginationResource')).pagination
      @set 'totalPages', @store.metadataFor(@get('paginationResource')).pagination.total_pages
    else
      @set 'totalPages', 1
      
    pages = []; i = page - 4
    
    while i <= page
      pages.push i if i > 0
      i += 1
    
    i = page + 1
    
    while i <= page + 4
      pages.push i if i <= @get('totalPages')
      i += 1
      
    pages = pages.map((item) ->
      number: item
      isCurrent: item is page
    ) 
    
    @set('pages', pages)   
    
  actions:
    goToPage: (page) ->
      @_goToPage(page)

      switch @get('paginationRoute')
        when 'community.feedbacks', 'community.problems', 'community.questions', 'community.ideas', 'community.praises', 'community.announcements'
          @transitionToRoute @get('paginationRoute'), @get('communitySlug'), page
        when 'community.feedback'
          @transitionToRoute @get('paginationRoute'), @get('communitySlug'), @get('slug'), page
        
    goToPageWithoutRedirect: (page) ->
      @_goToPage(page)