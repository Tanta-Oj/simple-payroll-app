require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Devise::Controllers::Helpers

  def setup
    @unconfirmed_user = users(:kenta)
    @confirmed_user   = users(:tanaka)
  end

  test "login with valid emial/invalid password" do
    get new_user_session_path
    assert_template "users/sessions/new"
    post user_session_path params: { user: { email:    @confirmed_user.email,
                                             password: "invalid" } }
    assert_not user_signed_in?
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with validuser/unconfirmed" do
    # deviseではconfirmed_atが空欄の場合、signinさせようとすると例外処理でエラーが返ってくるのでその確認
    get new_user_session_path
    assert @unconfirmed_user.confirmed_at.nil?
    e1 = assert_raises UncaughtThrowError do
      sign_in @unconfirmed_user
    end
    assert_equal "uncaught throw :warden", e1.message

    e2 = assert_raises UncaughtThrowError do
      post user_session_path, params: { user: { email:    @unconfirmed_user.email,
                                                password: "password" } }
      assert_not user_signed_in?
    end
    assert_equal "uncaught throw :warden", e2.message
  end
  
  test "login with validuser/confirmed followed by logout" do
    get new_user_session_path
    assert_select "a[href=?]", new_user_session_path
    post user_session_path params: { user: { email:    @confirmed_user.email,
                                             password: "password" } }
    assert user_signed_in?
    get root_url
    assert_select "a[href=?]", new_user_registration_path, count:0
    assert_select "a[href=?]", new_user_session_path, count:0
    assert_select "a[href=?]", new_member_session_path, count:0
    assert_select "a[href=?]", edit_user_registration_path
    assert_select "a[href=?]", destroy_user_session_path
    delete destroy_user_session_path
    follow_redirect!
    assert_select "a[href=?]", new_user_registration_path
    assert_select "a[href=?]", new_user_session_path
    assert_select "a[href=?]", new_member_session_path
    assert_select "a[href=?]", edit_user_registration_path, count:0
    assert_select "a[href=?]", destroy_user_session_path, count:0
  end
end
