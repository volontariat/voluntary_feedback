Volontariat.ReplyCommentsComponent = Ember.Component.extend
  actions:
    
    add: ->
      @set 'new', true
    
    leaveNewReplyCommentMode: ->
      @set 'new', false
      
    editReply: (id) ->
      @sendAction 'editAction', id

    leaveEditReplyMode: ->
      @sendAction 'leaveEditReplyModeAction'
      
    reload: ->
      @sendAction 'reloadAction'