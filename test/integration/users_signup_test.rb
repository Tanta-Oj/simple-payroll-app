require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Devise::Controllers::Helpers

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid signup infromation" do
    get new_user_registration_path
    assert_no_difference "User.count" do
      post user_registration_path, params: { user: { name:                  "",
                                                     email:                 "user@invalid",
                                                     password:              "foo",
                                                     password_confirmation: "bar" } }
    end
    assert_template "users/registrations/new"
    assert_select "div.alert", :count => 3
  end

  test "valid signup information with unconfirmed" do
    get new_user_registration_path
    assert_difference "User.count", 1 do
      post user_registration_path, params: { user: { name:                  "Example User",
                                                     email:                 "user@valid.com",
                                                     password:              "password",
                                                     password_confirmation: "password" } }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not user_signed_in?
  end

  test "valid signup information with confirmed" do
    get new_user_registration_path
    assert_difference "User.count", 1 do
      post user_registration_path, params: { user: { name:                  "Example User",
                                                     email:                 "user@valid.com",
                                                     password:              "password",
                                                     password_confirmation: "password" } }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = User.find_by(email: "user@valid.com")
    get user_confirmation_path(confirmation_token: user.confirmation_token)
    user.reload
    assert_not user.confirmed_at.nil?
    post user_session_path, params: { user: { email:    user.email,
                                              password: "password" } }
    assert user_signed_in?
  end
end
