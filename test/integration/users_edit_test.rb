require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Devise::Controllers::Helpers

  def setup
    @user = users(:tanaka)
  end

  test "unsuccessful edit" do
    get new_user_session_path
    # sign_in @user editにアクセスする時に、このログイン方法では正常に動かなかった
    post user_session_path params: { user: { email:    @user.email,
                                             password: "password" } }
    assert user_signed_in?
    get edit_user_registration_path(@user)
    assert_template "users/registrations/edit"
    new_name = ""
    put user_registration_path, params: { user: { name: new_name,
                                                  email: @user.email,
                                                  current_password: "password" } }
    assert_select "div.alert", count: 1
    assert_template "users/registrations/edit"
    @user.reload
    assert_not new_name == @user.name
  end

  test "successful edit" do
    get new_user_session_path
    # sign_in @user editにアクセスする時に、このログイン方法では正常に動かなかった
    post user_session_path params: { user: { email:    @user.email,
                                             password: "password" } }
    assert user_signed_in?
    get edit_user_registration_path(@user)
    assert_template "users/registrations/edit"
    new_name = "new name"
    put user_registration_path, params: { user: { name: new_name,
                                                  email: @user.email,
                                                  current_password: "password" } }
    assert_not flash.empty?
    @user.reload
    assert_equal new_name, @user.name
  end

  test "successful destroy" do
    get new_user_session_path
    post user_session_path params: { user: { email:    @user.email,
                                             password: "password" } }
    assert user_signed_in?
    get edit_user_registration_path(@user)
    assert_template "users/registrations/edit"
    delete user_registration_path
    assert_redirected_to root_url

    get new_user_session_path
    post user_session_path params: { user: { email:    @user.email,
                                             password: "password" } }
    assert_select "div.alert", count: 1
  end
end
