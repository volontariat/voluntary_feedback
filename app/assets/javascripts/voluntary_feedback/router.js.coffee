Volontariat.Router.reopen location: 'hash'

Volontariat.Router.map ->
  @_super
  
  @route 'communities', path: '/communities/page/:page'
  @route 'community', path: '/communities/:slug'
  @route 'new_community', path: '/communities/new'
  @route 'edit_community', path: '/communities/:slug/edit'