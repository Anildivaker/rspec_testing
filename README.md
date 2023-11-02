# README

Add active_admin on API based project 

------------step 1:-For resolving the Session error we have to modify application.rb (config/application.rb) file -------------

require_relative "boot"
require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
module RspecTesting
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore
    # config.middleware.use Rack::MethodOverride
    config.middleware.use ActionDispatch::Flash
    config.middleware.use Rack::MethodOverride
    # config.middleware.use ActionDispatch::Cookies
  end
end


-----------step:-2 When HTML will display without CSS then----------------
2:- Add assets folder (app/assets)
    2.1:- Create config folder inside assets (app/assets/config)
        2.1.1:- Inside config folder add manifest.js file (app/assets/config/manifest.js)
        
    2.2:- Create javascript folder inside assets (app/assets/javascript)
        2.2.1:- Inside javascript folder add active_admin.js file (app/assets/javascript/active_admin.js)
        ---------- modify the active_admin.js file ----------
        //= require active_admin/base

    2.3:- Create stylesheets folder inside assets (app/assets/stylesheets)
        2.3.1:- inside stylesheets folder add active_admin.scss file (app/assets/stylesheets/active_admin.scss)
        ---------- Modify the active_admin.scss file -------------
        @import "active_admin/mixins";
        @import "active_admin/base";


---------- Step:-3. Add 4 gemfiles -----------

gem 'devise'
gem 'activeadmin'
gem 'sass-rails'
gem 'sprockets'


----------- Step:-4. Modify application_controller.rb file -------------

    4.1:- modify this line 
        class ApplicationController < ActionController::API (wrong line)
                                to
        class ApplicationController < ActionController::Base (Correct line)

    4.2:- For removing one more session issue add these line
        include ActionView::Layouts
        protect_from_forgery unless: -> { request.format.json? }
        before_action :configure_permitted_parameters, if: :devise_controller?


-------- Step:-5. Many cookies are responsible for running active admin that's why we modify application_record.rb file -----

    replace ----

    class ApplicationRecord < ActiveRecord::Base
    primary_abstract_class
    end

    to this----

    class ApplicationRecord < ActiveRecord::Base
        primary_abstract_class
        def self.ransackable_attributes(auth_object = nil)
            authorizable_ransackable_attributes
        end
        def self.ransackable_associations(auth_object = nil)
            authorizable_ransackable_associations
        end
    end



