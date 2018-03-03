# Application template recipe for the rails_apps_composer.

raise if (defined? defaults) || (defined? preferences) # Shouldn't happen.
if options[:verbose]
  print "\nrecipes: ";p recipes
  print "\ngems: "   ;p gems
  print "\nprefs: "  ;p prefs
  print "\nconfig: " ;p config
end

case Rails::VERSION::MAJOR.to_s
when "5"
  prefs[:apps4] = multiple_choice "Choose application type:",
    [["Build a parbaked application", "parbaked"],
    ["Custom application using specific recipes", "none"]] unless prefs.has_key? :apps4
  case prefs[:apps4]
  when 'parbaked'
        prefs[:apps4] = multiple_choice "Choose a parbaked application.",
        [["rails-bootstrap", "rails-bootstrap"],
        ["rails-foundation", "rails-foundation"],
        ["rails-mailinglist-activejob", "rails-mailinglist-activejob"],
        ["rails-omniauth", "rails-omniauth"],
        ["rails-devise", "rails-devise"],
        ["rails-devise-roles", "rails-devise-roles"],
        ["rails-devise-pundit", "rails-devise-pundit"],
        ["rails-signup-download", "rails-signup-download"],
        ["rails-stripe-checkout", "rails-stripe-checkout"],
        ["rails-stripe-coupons", "rails-stripe-coupons"]]
  end
when "3"
  say_wizard "Please upgrade to Rails 4.1 or newer."
when "4"
  case Rails::VERSION::MINOR.to_s
  when "0"
    say_wizard "Please upgrade to Rails 4.1 or newer."
  else
    prefs[:apps4] = multiple_choice "Build a parbaked application?",
      [["Build a parbaked application", "parbaked"],
      ["Build a custom application", "none"]] unless prefs.has_key? :apps4
    case prefs[:apps4]
    when 'parbaked'
      case Rails::VERSION::MINOR.to_s
      when "2"
        prefs[:apps4] = multiple_choice "Choose a parbaked application.",
        [["rails-bootstrap", "rails-bootstrap"],
        ["rails-foundation", "rails-foundation"],
        ["rails-mailinglist-activejob", "rails-mailinglist-activejob"],
        ["rails-omniauth", "rails-omniauth"],
        ["rails-devise", "rails-devise"],
        ["rails-devise-roles", "rails-devise-roles"],
        ["rails-devise-pundit", "rails-devise-pundit"],
        ["rails-signup-download", "rails-signup-download"],
        ["rails-stripe-checkout", "rails-stripe-checkout"],
        ["rails-stripe-coupons", "rails-stripe-coupons"],
        ["rails-stripe-membership-saas", "rails-stripe-membership-saas"]]
      else
        prefs[:apps4] = multiple_choice "Upgrade to Rails 4.2 for more choices.",
        [["rails-bootstrap", "rails-bootstrap"],
        ["rails-foundation", "rails-foundation"],
        ["rails-omniauth", "rails-omniauth"],
        ["rails-devise", "rails-devise"],
        ["rails-devise-roles", "rails-devise-roles"],
        ["rails-devise-pundit", "rails-devise-pundit"]]
      end
    end
  end
end

__END__

name: parbaked
description: "Install parbaked or customer Rails applications."
author: RailsApps

requires: [core]
run_after: [git]
category: configuration
