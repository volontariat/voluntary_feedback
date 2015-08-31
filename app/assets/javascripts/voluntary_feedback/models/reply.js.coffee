Volontariat.Reply = DS.Model.extend
  userId: DS.attr('number')
  userName: DS.attr('string')
  userSlug: DS.attr('string')
  feedbackId: DS.attr('number')
  text: DS.attr('string')