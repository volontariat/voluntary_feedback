$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'voluntary_feedback/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'voluntary_feedback'
  s.version     = VoluntaryFeedback::VERSION
  s.authors     = ['Mathias Gawlista']
  s.email       = ['gawlista@gmail.com']
  s.homepage    = 'http://Voluntary.Software'
  s.summary     = 'Draft: plugin for crowdsourcing management system voluntary where users can post feedback like commentable and voteable questions, problems, praise and ideas to a project.'
  s.description = '#Ruby on #Rails plugin for Voluntary.Software about user feedback for a product.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'voluntary', '~> 0.2.2'

  s.add_development_dependency 'mysql2'
end
