# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Imp::Application.initialize!

ENV['SSL_CERT_FILE'] = '/Users/David/Programming/rails/imp/config/cacert.pem'
