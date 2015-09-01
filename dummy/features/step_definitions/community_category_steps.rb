When /^delete the first community category$/ do
  page.evaluate_script('window.confirm = function() { return true; }')
  find(:xpath, '(//a[@class="remove_category_link"])[1]').click
end