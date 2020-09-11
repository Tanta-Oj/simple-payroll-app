require 'test_helper'

class UsersPasswordResetsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Devise::Controllers::Helpers

  def setup
    ActionMailer::Base.deliveries.clear

    # request.env["devise.mapping"] = Devise.mappings[:user]
    @user = users(:tanaka)
  end

  test "password resets" do
    get new_user_password_path
    assert_template "users/passwords/new"

    post user_password_path, params: { user: { email: "" } }
    assert_select "div.alert", :count => 1
    assert_template "users/passwords/new"

    post user_password_path, params: { user: { email: @user.email } }
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_redirected_to new_user_session_url

    # message = ActionMailer::Base.deliveries[0].to_s
    # rpt_index = message.index("reset_password_token")+"reset_password_token".length+1
    # reset_password_token = message[rpt_index...message.index("\"", rpt_index)]
    # dbに保存されているtoeknとメールに添付されるtokenは一致しないのでメールに添付されたtokenを取得する必要がある
    # send_reset_password_instructionsメソッドでreset_password_tokenを再発行してテストしている
    reset_password_token = @user.send_reset_password_instructions
    @user.reload
    get edit_user_password_path(reset_password_token: reset_password_token)
    assert_template "users/passwords/edit"

    put user_password_path, params: { user: { reset_password_token:  reset_password_token,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_select "div.alert", count: 1

    new_password = "newpassword"
    put user_password_path, params: { user: { reset_password_token:  reset_password_token,
                                              password:              new_password,
                                              password_confirmation: new_password } }

    @user.reload
    assert_not flash.empty?
    assert_redirected_to root_url
    assert user_signed_in?
    delete destroy_user_session_path
    follow_redirect!
    assert_select "a[href=?]", new_user_registration_path
    assert_select "a[href=?]", new_user_session_path
    assert_select "a[href=?]", edit_user_registration_path, count:0
    assert_select "a[href=?]", destroy_user_session_path, count:0
    get new_user_session_path
    post user_session_path params: { user: { email:    @user.email,
                                             password: new_password } }
    get root_url
    assert_select "a[href=?]", new_user_registration_path, count:0
    assert_select "a[href=?]", new_user_session_path, count:0
    assert_select "a[href=?]", edit_user_registration_path
    assert_select "a[href=?]", destroy_user_session_path
  end

end
