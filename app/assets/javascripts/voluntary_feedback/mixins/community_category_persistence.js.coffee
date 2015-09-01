Volontariat.CommunityCategoryPersistence = Em.Mixin.create
  actions:
    
    save: ->
      $.ajax(
        type: if @get('categorySlug') then 'PUT' else 'POST'
        url: '/api/v1/community_categories' + if @get('categorySlug') then "/#{@get('categorySlug')}" else '', 
        data: { 
          community_category: { community_slug: @get('communitySlug'), name: $('#community_category_name').val() } 
        }
      ).success((data) =>
        if data.errors
          Volontariat.alert 'danger', "#{Volontariat.t('community_categories.save.failed')}: #{JSON.stringify(data.errors)}"
        else
          @transitionToRoute 'community.category.feedbacks', @get('communitySlug'), data.community_category.slug, 1
          Volontariat.alert 'success', Volontariat.t('community_categories.save.successful')
      ).fail((data) =>
        Volontariat.alert 'danger', "#{Volontariat.t('community_categories.save.failed')}!"
      )
      
    destroy: (slug)  ->
      if confirm(Volontariat.t('community_categories.destroy.confirmation'))
        $.ajax("/api/v1/community_categories/#{slug}?community_slug=#{@get('communitySlug')}", type: 'DELETE').done((data) =>
          @set 'categorySlug', null
          @transitionToRoute 'no_data'
          @transitionToRoute 'community.categories', @get('communitySlug'), 1 
        ).fail((data) ->
          Volontariat.alert 'danger', Volontariat.t('activerecord.errors.models.community_category.attributes.base.deletion_failed')
        ) 