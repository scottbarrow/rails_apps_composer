# Application template recipe for the rails_apps_composer. Change the recipe here:
# https://github.com/RailsApps/rails_apps_composer/blob/master/recipes/readme.rb

stage_three do
  say_wizard "recipe stage three"

  # remove default READMEs
  %w{
    README
    README.rdoc
    doc/README_FOR_APP
  }.each { |file| remove_file file }

  # add diagnostics to README
  create_file 'README', "#{app_name.humanize.titleize}\n================\n\n"
  append_to_file 'README' do <<-TEXT
Template options used: \n
Web server for development: [#{prefs[:dev_webserver]}]
Web server for production: [#{prefs[:prod_webserver]}]
Database used in development: [#{prefs[:database]}]
Template engine: [#{prefs[:templates]}]
Test framework: [#{prefs[:tests]}]
Front-end framework: [#{prefs[:frontend]}]
Support for sending email: [#{prefs[:email]}]
Authentication: [#{prefs[:authentication]}]
Devise modules: [#{prefs[:devise_modules]}]
OmniAuth provider: [#{prefs[:omniauth_provider]}]
Authorization: [#{prefs[:authorization]}]
Form builder: [#{prefs[:form_builder]}]
Pages: [#{prefs[:pages]}]
Locale(s): [#{prefs[:locale]}]
Page-view analytics: [#{prefs[:analytics]}]
Deployment mechanism: [#{prefs[:deployment]}]
robots.txt file (to ban spiders): [#{prefs[:ban_spiders]}]
Created a GitHub repository: [#{prefs[:github]}]
Environment variable management: [#{prefs[:local_env_file]}]
Pry installed for development and test: [#{prefs[:pry]}]
Project-specific rvm gemset: [#{prefs[:rvmrc]}]
TEXT
  end

  remove_file 'README.md'
  create_file 'README.md', "#{app_name.humanize.titleize}\n================\n\n"

  if prefer :deployment, 'heroku'
    append_to_file 'README.md' do <<-TEXT
[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

TEXT
    end
  end

  append_to_file 'README.md' do <<-TEXT
Ruby on Rails
-------------

This application requires:

- Ruby #{RUBY_VERSION}
- Rails #{Rails::VERSION::STRING}


Getting Started
---------------

Documentation and Support
-------------------------

Issues
-------------

Similar Projects
----------------

Contributing
------------

Credits
-------

License
-------
TEXT
  end

  git :add => '-A' if prefer :git, true
  git :commit => '-qm "rails_apps_composer: add README files"' if prefer :git, true

end

__END__

name: readme
description: "Build a README file for your application."
author: RailsApps

requires: [setup]
run_after: [setup]
category: configuration
