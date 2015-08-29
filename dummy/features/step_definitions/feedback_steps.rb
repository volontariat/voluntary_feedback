Given /^a feedback$/ do
  @feedback = FactoryGirl.create(:feedback, user: @me)
  @community = @feedback.community
end

When /^I click the new feedback link$/ do
  find(:xpath, '(//a[@class="new_feedback_link ember-view"])[1]').click
end

When /^I click the edit link of the first feedback$/ do
  find(:xpath, '(//a[@class="edit_feedback_link ember-view"])[1]').click
end

When /^I click the remove link of the first feedback$/ do
  find(:xpath, '(//a[@class="remove_feedback_link"])[1]').click
end