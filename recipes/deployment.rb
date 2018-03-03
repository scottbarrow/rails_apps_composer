# Application template recipe for the rails_apps_composer. Change the recipe here:
# https://github.com/RailsApps/rails_apps_composer/blob/master/recipes/deployment.rb

prefs[:deployment] = multiple_choice "Prepare for deployment?", [["no", "none"],
    ["Cloud66", "cloud66"],
    ["Heroku", "heroku"],
    ["Capistrano", "capistrano3"]] unless prefs.has_key? :deployment

if prefer :deployment, 'cloud66'
  stage_two do
    say_wizard "recipe stage two"
    say_wizard "installing Cloud66 toolbelt"
    # Fetch the download script
    get "https://s3.amazonaws.com/downloads.cloud66.com/cx_installation/cx_install.sh" do |content|
      run content, verbose: false, capture: false
      "./tmp/cx_install.sh"
    end
    # Cleanup
    remove_file "/tmp/c66_toolbelt.tar.gz"
    remove_file "./tmp/cx_install.sh"
    # Create C66 manifest file
    create_file "./.cloud66/manifest.yml"
  end
end

if prefer :deployment, 'heroku'
  say_wizard "installing gems for Heroku"
  if prefer :database, 'sqlite'
    gsub_file 'Gemfile', /.*gem 'sqlite3'\n/, ''
    add_gem 'sqlite3', group: [:development, :test]
    add_gem 'pg', group: :production
  end
end

if prefer :deployment, 'capistrano3'
  say_wizard "installing gems required for Capistrano"
  add_gem 'capistrano', '~> 3.0.1', group: :development
  add_gem 'capistrano-rvm', '~> 0.1.1', group: :development
  add_gem 'capistrano-bundler', group: :development
  add_gem 'capistrano-rails', '~> 1.1.0', group: :development
  add_gem 'capistrano-rails-console', group: :development
  stage_two do
    say_wizard "recipe stage two"
    say_wizard "installing Capistrano files"
    run 'bundle exec cap install'
  end
end

stage_three do
  ### GIT ###
  git :add => '-A' if prefer :git, true
  git :commit => '-qm "rails_apps_composer: prepare for deployment"' if prefer :git, true
end

__END__

name: deployment
description: "Prepare for deployment"
author: RailsApps

requires: [setup]
run_after: [init]
category: development
