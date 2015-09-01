Volontariat.FeedbackPersistence = Em.Mixin.create
  categories: []
  
  actions:
    
    save: ->
      categoryIds = jQuery.map($('input[name="category_ids[]"]:checked'), (categoryField) ->
        $(categoryField).val()
      )
        
      $.ajax(
        type: if @get('slug') then 'PUT' else 'POST'
        url: '/api/v1/feedbacks' + if @get('slug') then "/#{@get('slug')}" else '', 
        data: { 
          feedback: { 
            community_slug: @get('communitySlug'), feedback_type: $('#feedback_feedback_type').val()
            name: $('#feedback_name').val(), text: $('#feedback_text').val(),
            mood_type: $('input[name="feedback[mood_type]"]:checked').val(), mood_text: $('#feedback_mood_text').val(),
            category_ids: categoryIds
          } 
        }
      ).success((data) =>
        if data.errors
          Volontariat.alert 'danger', "#{Volontariat.t('feedbacks.save.failed')}: #{JSON.stringify(data.errors)}"
        else
          @transitionToRoute 'community.feedback', @get('communitySlug'), data.feedback.slug, 1
          Volontariat.alert 'success', Volontariat.t('feedbacks.save.successful')
      ).fail((data) =>
        Volontariat.alert 'danger', "#{Volontariat.t('feedbacks.save.failed')}!"
      )
      
    destroy: (slug)  ->
      if confirm(Volontariat.t('feedbacks.destroy.confirmation'))
        $.ajax("/api/v1/feedbacks/#{slug}?community_slug=#{@get('communitySlug')}", type: 'DELETE').done((data) =>
          @transitionToRoute 'no_data'
          @transitionToRoute 'community.feedbacks', @get('communitySlug'), 1 
        ).fail((data) ->
          Volontariat.alert 'danger', Volontariat.t('activerecord.errors.models.feedback.attributes.base.deletion_failed')
        ) 