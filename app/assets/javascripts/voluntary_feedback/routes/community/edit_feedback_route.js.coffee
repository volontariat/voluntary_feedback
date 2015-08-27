Volontariat.CommunityEditFeedbackRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('community.edit_feedback').set 'communitySlug', @modelFor('community').slug
    @controllerFor('community.edit_feedback').set 'slug', params.feedback_slug    
    
    Ember.$.getJSON("/api/v1/feedbacks/#{params.feedback_slug}?community_slug=#{@modelFor('community').slug}").then (json) =>
      @controllerFor('community.edit_feedback').set 'name', json.feedback.name
      @controllerFor('community.edit_feedback').set 'text', json.feedback.text
      @controllerFor('community.edit_feedback').set 'moodText', json.feedback.mood_text
      
      setTimeout (=>
        $('#feedback_feedback_type').val(json.feedback.feedback_type)
        
        unless json.feedback.mood_type == null
          $('input[name="feedback[mood_type]"][value="' + json.feedback.mood_type + '"]').click()
      ), 100