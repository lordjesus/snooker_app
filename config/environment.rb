# Load the Rails application.
require File.expand_path('../application', __FILE__)

ActionMailer::Base.default_url_options{ :host => 'snookerdk.herokuapp.com' }
ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['SENDGRID_USERNAME'],
  :password       => ENV['SENDGRID_PASSWORD'],
  :domain         => 'snookerdk.herokuapp.com',
  :enable_starttls_auto => true
}

# Initialize the Rails application.
SnookerApp::Application.initialize!
