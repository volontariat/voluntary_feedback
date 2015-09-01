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
      
    Ember.$.getJSON(
      "/api/v1/community_categories.json?community_slug=#{@modelFor('community').slug}"
    ).then (json) =>
      @controllerFor('community.edit_feedback').set 'categories', json.community_categories
      
      Ember.$.getJSON(
        "/api/v1/community_categories.json?community_slug=#{@modelFor('community').slug}&feedback_slug=#{params.feedback_slug}"
      ).then (json) =>
        setTimeout (->
          jQuery.each json.community_categories, (i, category) ->
            $("input[name='category_ids[]'][value='#{category.id}']").click()
        ), 100
