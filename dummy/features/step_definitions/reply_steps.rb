When /^I click the new reply link$/ do
  find(:xpath, '(//a[@class="new_reply_link"])[1]').click
end

When /^I click the edit link of the first reply$/ do
  find(:xpath, '(//a[@class="edit_reply_link"])[1]').click
end

When /^I click the remove link of the first reply$/ do
  find(:xpath, '(//a[@class="remove_reply_link"])[1]').click
end