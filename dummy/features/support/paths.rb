# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
     
    # authentication
    when /^the sign in page$/
      new_user_session_path  
    
    # feedback
    when /the communities page/
      "/products/feedback#/communities/page/1"  
      
    when /the new community page/
      "/products/feedback#/communities/new"  

    when /the community page/
      "/products/feedback#/communities/#{Community.last.slug}/feedbacks/page/1"  

    when /the community edit page/
      "/products/feedback#/communities/#{Community.last.slug}/edit"  
    
    when /the feedback page/
      "/products/feedback#/communities/#{@community.slug}/feedbacks/#{@feedback.slug}/page/1"
      
    # workflow
    when /the workflow page/
      workflow_path
    
    when /the edit workflow task page/
      edit_task_workflow_user_index_path(@task || @story.tasks.last)
    
    when /the project owner's workflow page/
      workflow_project_owner_index_path
       
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
  
  def login_page
    path_to "the new user session page"
  end
end

World(NavigationHelpers)
