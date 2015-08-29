Volontariat.CommunityFeedbacksController = Volontariat.Controller.extend(Volontariat.PaginationController, Volontariat.FeedbackPersistence,
  paginationResource: 'feedback'
  
  anyItems: (-> @get('content.length') > 0).property('content')
  feedbackClass: (-> if @get('feedbackType') == 'Feedback' then 'active' else '').property('feedbackType')
  problemClass: (-> if @get('feedbackType') == 'Problem' then 'active' else '').property('feedbackType')
  questionClass: (-> if @get('feedbackType') == 'Question' then 'active' else '').property('feedbackType')
  ideaClass: (-> if @get('feedbackType') == 'Idea' then 'active' else '').property('feedbackType')
  praiseClass: (-> if @get('feedbackType') == 'Praise' then 'active' else '').property('feedbackType')
  announcementClass: (-> if @get('feedbackType') == 'Announcement' then 'active' else '').property('feedbackType')
)