Volontariat.ReplyCellComponent = Ember.Component.extend
  editMode: (-> @get('selectedId') == @get('id')).property('selectedId', 'id')
  your: (-> Volontariat.User.current() != undefined && Volontariat.User.current().id == @get('userId')).property('userId')
  
  actions:
    
    edit: ->
      @sendAction 'editAction', @get('id')
    
    cancel: ->
      if @get 'id'
        @sendAction 'leaveEditReplyModeAction'
      else
        @sendAction 'leaveNewReplyModeAction'
        
    save: ->
      $.ajax(
        type: if @get('id') then 'PUT' else 'POST'
        url: '/api/v1/replies' + if @get('id') then "/#{@get('id')}" else '', 
        data: { 
          reply: { feedback_id: @get('feedbackId'), reply_id: @get('replyId'), text: $('#reply_text').val() } 
        }
      ).success((data) =>
        if data.errors
          alert "#{Volontariat.t('replies.save.failed')}: #{JSON.stringify(data.errors)}"
        else
          if @get('id')
            @sendAction 'leaveEditReplyModeAction'
          else
            @sendAction 'leaveNewReplyModeAction'
            @set 'text', ''
          
          @sendAction 'reloadAction'
      ).fail((data) =>
        alert "#{Volontariat.t('replies.save.failed')}!"
      )
      
    destroy: ->
      if confirm(Volontariat.t('replies.destroy.confirmation'))
        $.ajax("/api/v1/replies/#{@get('id')}", type: 'DELETE').done((data) =>
          @sendAction 'reloadAction'
        ).fail((data) ->
          alert Volontariat.t('activerecord.errors.models.reply.attributes.base.deletion_failed')
        ) 