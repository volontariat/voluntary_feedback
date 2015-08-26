Given /^an organization assigned to me$/ do
  @organization = FactoryGirl.create(:organization, user: @me)
end