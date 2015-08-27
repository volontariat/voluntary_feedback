Ember.Handlebars.helper 'mood-icon', (index, options) ->
  if index == 0
    new (Ember.Handlebars.SafeString)('<img src="http://twemoji.maxcdn.com/72x72/1f600.png" style="width:16px; height:16px;"/>')
  else if index == 1
    new (Ember.Handlebars.SafeString)('<img src="http://twemoji.maxcdn.com/72x72/1f60b.png" style="width:16px; height:16px;"/>')
  else if index == 2
    new (Ember.Handlebars.SafeString)('<img src="http://twemoji.maxcdn.com/72x72/1f610.png" style="width:16px; height:16px;"/>')
  else if index == 2
    new (Ember.Handlebars.SafeString)('<img src="http://twemoji.maxcdn.com/72x72/1f61f.png" style="width:16px; height:16px;"/>')
  else
    '-'