# Application template recipe for the rails_apps_composer. Change the recipe here:
# https://github.com/RailsApps/rails_apps_composer/blob/master/recipes/frontend.rb

stage_two do
  stylesheet_path = "app/assets/stylesheets"

  say_wizard "recipe stage two"
  # set up a front-end framework using the rails_layout gem
  case prefs[:frontend]
    when 'simple'
      generate 'layout:install simple -f'
    when 'bootstrap3'
      generate 'layout:install bootstrap3 -f'
    when 'bootstrap4'
      generate 'layout:install bootstrap4 -f'
    when 'foundation5'
      generate 'layout:install foundation5 -f'
    when 'foundation6'
      generate 'layout:install foundation6 -f'
    when 'tachyons'
      # css
      if File.file?("#{stylesheet_path}/application.css")
        inject_into_file "#{stylesheet_path}/application.css", " *= require tachyons-min\n", before: " */"
      # css.scss
      elsif File.file?("#{stylesheet_path}/application.css.scss")
        inject_into_file "#{stylesheet_path}/application.css.scss", " *= require tachyons-min\n", before: " */"
      # scss
      elsif File.file?("#{stylesheet_path}/application.scss")
        inject_into_file "#{stylesheet_path}/application.scss", " @import tachyons-min\n", before: " */"
      end
    else
      case prefs[:jquery]
        when 'gem', 'yarn'
        say_wizard "modifying application.js for jQuery"
        insert_into_file('app/assets/javascripts/application.js', "//= require jquery\n", :before => /^ *\/\/= require rails-ujs/, :force => false)
      end
  end

  ### GIT ###
  git :add => '-A' if prefer :git, true
  git :commit => '-qm "rails_apps_composer: front-end framework"' if prefer :git, true
end

__END__

name: frontend
description: "Install a front-end framework for HTML5 and CSS."
author: RailsApps

requires: [setup, gems]
run_after: [setup, gems, devise, omniauth, roles]
category: frontend
