Volontariat.Router.reopen location: 'hash'

Volontariat.Router.map ->
  @_super
  
  @route 'communities', path: '/communities/page/:page'
  
  @resource 'community', path: '/communities/:slug', ->
    @route 'feedbacks', path: 'feedbacks/page/:page'
    @route 'problems', path: 'problems/page/:page'
    @route 'questions', path: 'questions/page/:page'
    @route 'ideas', path: 'ideas/page/:page'
    @route 'praises', path: 'praises/page/:page'
    @route 'announcements', path: 'announcements/page/:page'
    
    @route 'new_feedback', path: 'feedbacks/new'
    @route 'feedback', path: 'feedbacks/:feedback_slug/page/:page'
    @route 'edit_feedback', path: 'feedbacks/:feedback_slug/edit'
    
  @route 'new_community', path: '/communities/new'
  @route 'edit_community', path: '/communities/:slug/edit'