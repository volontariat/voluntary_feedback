Volontariat.CommunityFeedbackController = Volontariat.Controller.extend(Volontariat.PaginationController, Volontariat.FeedbackPersistence,
  paginationRoute: 'community.feedback', paginationResource: 'reply', replies: [], newReplyMode: false
  anyReplies: (-> @get('replies.length') > 0).property('replies')
  feedbackTypeRoute: (-> "community.#{@get('feedbackType').pluralize().toLowerCase()}").property('feedbackType')
  
  actions:
    
    newReply: ->
      @set 'replyId', null
      @set 'newReplyMode', true
      
    leaveNewReplyMode: ->
      @set 'newReplyMode', false  
      
    editReply: (id) ->
      @set 'newReplyMode', false 
      @set 'replyId', id
      
    leaveEditReplyMode: ->
      @set 'replyId', null
    
    reload: ->
      @transitionToRoute 'no_data'
      @transitionToRoute 'community.feedback', @get('communitySlug'), @get('slug'), @get('page')
)