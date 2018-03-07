# Application template recipe for the rails_apps_composer. Change the recipe here:
# https://github.com/RailsApps/rails_apps_composer/blob/master/recipes/core.rb

## Git
say_wizard "selected all core recipes"

__END__

name: core
description: "Core recipes known to work together (git, setup, readme, tests, email, devise etc...)"
author: RailsApps

requires: [git, parbaked,
  # learn_rails, #TODO replace with Ballistiq app types e.g. subscription, video site
  rails_bootstrap,
  rails_foundation,
  rails_omniauth,
  rails_devise,
  rails_devise_roles,
  rails_devise_pundit,
  rails_signup_download,
  rails_mailinglist_activejob,
  rails_stripe_checkout,
  rails_stripe_coupons,
  setup, locale, readme, gems,
  tests,
  email,
  devise, omniauth, roles,
  frontend, pages,
  init, analytics, deployment, extras]
category: collections
