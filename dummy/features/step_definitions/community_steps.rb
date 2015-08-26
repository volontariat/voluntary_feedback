When /^delete the first community/ do
  find(:xpath, '(//a[@class="remove_community_link"])[1]').click
  
  step %(I confirm the following alert)
end