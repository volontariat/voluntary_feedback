Volontariat.CommunityPersistence = Em.Mixin.create
  organizations: []
  
  actions:
    
    save: ->
      $.ajax(
        type: if @get('slug') then 'PUT' else 'POST'
        url: '/api/v1/communities' + if @get('slug') then "/#{@get('slug')}" else '', 
        data: { 
          community: { 
            organization_id: $('#community_organization_id').val(), name: $('#community_name').val(), 
            text: $('#community_text').val() 
          } 
        }
      ).success((data) =>
        if data.errors
          Volontariat.alert 'danger', "#{Volontariat.t('communities.save.failed')}: #{JSON.stringify(data.errors)}"
        else
          @transitionToRoute 'community.feedbacks', data.community.slug, 1
          Volontariat.alert 'success', Volontariat.t('communities.save.successful')
      ).fail((data) =>
        Volontariat.alert 'danger', "#{Volontariat.t('communities.save.failed')}!"
      )
      
    destroy: (slug)  ->
      if confirm(Volontariat.t('communities.destroy.confirmation'))
        $.ajax("/api/v1/communities/#{slug}", type: 'DELETE').done((data) =>
          @transitionToRoute 'no_data'
          @transitionToRoute 'communities', 1 
        ).fail((data) ->
          Volontariat.alert 'danger', Volontariat.t('activerecord.errors.models.community.attributes.base.deletion_failed')
        ) 