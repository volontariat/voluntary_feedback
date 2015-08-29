Volontariat.CommunityFeedbackRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('community.feedback').set 'page', parseInt(params.page)
    @controllerFor('community.feedback').set 'communitySlug', @modelFor('community').slug
    @controllerFor('community.feedback').set 'slug', params.feedback_slug
    
    Ember.$.getJSON("/api/v1/feedbacks/#{params.feedback_slug}?community_slug=#{@modelFor('community').slug}").then (json) =>
      @controllerFor('community.feedback').set 'feedbackType', json.feedback.feedback_type
      
      Ember.$.getJSON(
        "/api/v1/replies?feedback_id=#{json.feedback.id}&page=#{params.page}"
      ).then (replyJson) =>
        @controllerFor('community.feedback').set 'metadata', replyJson.meta
        
        replies = $.map replyJson.replies, (reply, i) ->
          reply.replies = $.map reply.replies, (subReply, i) ->
            subReply.reply
            
          reply
        
        @controllerFor('community.feedback').set 'replies', replies
        @controllerFor('community.feedback').send 'goToPageWithoutRedirect', parseInt(params.page)
      
      json.feedback
      
  setupController: (controller, model) ->
    controller.send('goToPageWithoutRedirect', controller.get('page'))
    controller.set('model', model)