ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require "authlogic/test_case" # include at the top of test_helper.rb
require 'shoulda'
require 'factory_girl'
require File.expand_path(File.dirname(__FILE__) + "/factories")

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
end

class ActionController::TestCase
    setup :activate_authlogic
end

# useful method for functional tests that require an authenticated user
def set_current_user(this_user)
  #@user = Factory(:user)
  @controller.stub!(:current_user, :return => this_user)
end

