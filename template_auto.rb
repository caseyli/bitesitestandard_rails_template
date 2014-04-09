# TESTED FOR RAILS 4 APPLICATIONS

def source_paths
  Array(super) + 
    [File.join(File.expand_path(File.dirname(__FILE__)),'rails_root')]
end

# ALL APPLICATIONS ===================================================================================================================================

# Gems
gem "rails_12factor", group: "production"
gem "jquery-turbolinks"

# RVM and Heroku
append_file 'Gemfile' do <<-RUBY
  \n\nruby '2.0.0'\n#ruby-gemset=#{@app_name}
RUBY
end

# Assets
inside "lib" do
  inside "assets" do
    inside "stylesheets" do
      copy_file "reset.css.scss"
    end
  end
end

inject_into_file 'app/assets/stylesheets/application.css', :before => " *= require_tree ." do <<-'CSS' 
*= require reset
CSS
end

inject_into_file 'app/assets/javascripts/application.js', :after => "//= require jquery\n" do <<-'CSS' 
//= require jquery.turbolinks
CSS
end


# Controllers
generate :controller, "Pages", "home"

# Routes
route "root 'pages#home'"

# Git Ignore
copy_file ".gitignore"


# E-MAILS ============================================================================================================================================
gem "letter_opener", group: "development"
environment "config.action_mailer.delivery_method = :letter_opener", env: "development"
environment "config.action_mailer.default_url_options = { host: 'localhost:3000' }", env: "development"

# production_host = ask("What is your production host? (www.yoursite.com)")
production_host = "www.yoursite.com" if production_host.blank?
environment "config.action_mailer.delivery_method = :smtp", env: "production"
environment "config.action_mailer.default_url_options = { :host => '#{production_host}' }", env: "production"
environment "config.action_mailer.smtp_settings = { :address => 'smtp.gmail.com', :port => 587, :user_name => ENV['SMTP_USER'], :password => ENV['SMTP_PASSWORD'], :authentication => 'plain', :enable_starttls_auto => true }", env: "production"


# DEVISE ============================================================================================================================================


# Install Devise ------------------
gem "devise"
run "bundle install"

# Create User Model ------------------
generate "devise:install"
# model_name = ask("What would you like the user model to be called? [user]")
model_name = "user" if model_name.blank?
generate "devise", model_name

# Add signed in bar and flash view elements ------------------
inside "app" do
  inside "views" do
    inside "layouts" do
      copy_file "_flash.html.erb"
      copy_file "_signed_in_bar.html.erb"
      
      remove_file "application.html.erb"
      template "signed_in_application.html.erb", "application.html.erb"
    end
  end
end

inside "lib" do
  inside "assets" do
    inside "javascripts" do
      copy_file "flash.js"
    end
    inside "stylesheets" do
      copy_file "signed_in_bar.css.scss"
      copy_file "flash.css.scss"
    end
  end
end

inject_into_file 'app/assets/stylesheets/application.css', :before => " *= require_tree ." do <<-'CSS' 
*= require flash
*= require signed_in_bar
CSS
end

inject_into_file 'app/assets/javascripts/application.js', :before => "//= require_tree ." do <<-'CSS' 
//= require flash
CSS
end

# Routes -----------
route 'get "/signin" => redirect("/users/sign_in")'
route 'get "/register" => redirect("/users/sign_up")'
route 'get "/signup" => redirect("/users/sign_up")'

# Create Roles ------------------

generate :model, "Role", "name"
generate :migration, "CreateJoinTable", "roles", "users"

inside "app" do
  inside "models" do
    # Flesh out User Role methods
    remove_file "user.rb"
    copy_file "user.rb"

    # Add has_and_belongs_to_many users
    remove_file "role.rb"
    copy_file "role.rb"
  end
end


inside "app" do
  inside "helpers" do
    copy_file "sessions_helper.rb"
  end
end

# Seed admin role
append_file 'db/seeds.rb' do <<-'RUBY'
  admin_role = Role.find_or_create_by(name: "admin")
RUBY
end
  
