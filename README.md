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



----------- Steps for mailer ---------
1. rails g mailer article_mailer 
2. app/mailer/article_mailer (modify this file)
3. create welcome_email.html.erb file inside app/view/article_mailer
4. mofify app/view/article_mailer file
5. mofigy app/config/development.rb for local (config.action_mailer.raise_delivery_errors = true)
6. mofigy app/config/development.rb for local-----
(config.action_mailer.default_url_options = { :host => 'localhost:3000', protocol: 'http' }
  config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,                      (this port will not change)
    domain: 'localhost:3000',
    user_name: "anildivaker87@gmail.com",
    password: "eccq dbow tqvn zwqp",   (this is generated by gmail from security/app development)
    :authentication       => "plain",
  :enable_starttls_auto => true
  })
  7. modify app/controllers/articles_controller.rb 
    write trigger code when you want to send the mail 
    ArticleMailer.welcome_email(@article).deliver


--------------arctic-admin----------------
1. Add this to your Gemfile:
    gem 'arctic_admin'

2. Run bundle install.

3. Add this line to the file config/initializers/active_admin.rb

meta_tags_options = { viewport: 'width=device-width, initial-scale=1' }
config.meta_tags = meta_tags_options
config.meta_tags_for_logged_out_pages = meta_tags_options

4. Remove the line @import "active_admin/base" from active_admin.css
    If you use the Sass indented syntax, add this to your active_admin.sass file:
    $primary-color: #2dbb43  <- this is color code you can change if you want
    @import arctic_admin/base
            or
    If you prefer SCSS, add this to your active_admin.scss file:
    $primary-color: #2dbb43; <- this is color code you can change if you want
    @import "arctic_admin/base";

5. In your active_admin.js, include the js file:
    //= require arctic_admin/base
    Remove the line //= require active_admin/base


-----------Add logo on active admin (top left side)------------
1. create folder of images (app/assets/images)
2. Add image inside images folder (app/assets/images/logo.png)
3. Add new line in application.rb file inside this class (class Application < Rails::Application)
    config.assets.precompile += %w(.png)
4. On Active_admin.rb file uncomment or add this line
    config.site_title_image = "logo.png"
5. Run this command on terminal
    rails assets:precompile
6. Add new line in manifest.js file (app/assets/config/manifest.js)
    //= link logo.png
7. Run server and check on browser





-----------Radis Server setup-----------------
1. Add gems
    gem 'sidekiq', "< 7" (this is for sidekiq)
    bundle install

2. Open terminal
    rails g job update_author_name

3. Open update_author_name file (app/update_author_name.rb)
    class UpdateAuthorNameJob < ApplicationJob
        queue_as :default

        def perform(user)
            user.update(name: "google")
        end
    end

4. Add this line in application.rb file 
    module Blog
        class Application < Rails::Application
            config.active_job.queue_adapter = :sidekiq
            
        end
    end

5. Open Console (rails c)
    5.1  create a new author

6.  redis server commands 
    For running the server:-  redis-server
    For Checking the Status:- sudo systemctl status redis
    For Re-starting the server:- sudo systemctl restart redis.service
    For stoping the server:-  sudo systemctl stop redis

7. sidekiq commands   
    For running the sidekiq:-  bundle exe sidekiq

8. Ater setup redis and sidekiq open console 
    UpdateAuthorNameJob.set(wait: 10.seconds).perform_later(Author.name)
                        or 
    UpdateAuthorName.job.perform_now(Author.name)
    


    