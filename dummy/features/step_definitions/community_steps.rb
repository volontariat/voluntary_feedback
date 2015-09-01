Given /^a community$/ do
  @community = FactoryGirl.create(:community)
end

Given /^a community assigned to me$/ do
  @community = FactoryGirl.create(:community, organization: FactoryGirl.create(:organization, user: @me))
end

When /^delete the first community$/ do
  find(:xpath, '(//a[@class="remove_community_link"])[1]').click
  
  step %(I confirm the following alert)
end