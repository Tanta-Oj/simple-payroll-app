require 'test_helper'

class MembersLoginTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Devise::Controllers::Helpers

  def setup
    @unconfirmed_member = members(:member1)
    @confirmed_member   = members(:member2)
  end

  test "login with valid emial/invalid password" do
    get new_member_session_path
    assert_template "members/sessions/new"
    post member_session_path params: { member: { email:    @confirmed_member.email,
                                                 password: "invalid" } }
    assert_not member_signed_in?
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with validmember/unconfirmed" do
    # deviseではconfirmed_atが空欄の場合、signinさせようとすると例外処理でエラーが返ってくるのでその確認
    get new_member_session_path
    assert @unconfirmed_member.confirmed_at.nil?
    e1 = assert_raises UncaughtThrowError do
      sign_in @unconfirmed_member
    end
    assert_equal "uncaught throw :warden", e1.message

    e2 = assert_raises UncaughtThrowError do
      post member_session_path, params: { member: { email:    @unconfirmed_member.email,
                                                    password: "password" } }
      assert_not member_signed_in?
    end
    assert_equal "uncaught throw :warden", e2.message
  end

  test "login with validmember/confirmed followed by logout" do
    get new_member_session_path
    assert_select "a[href=?]", new_member_session_path
    post member_session_path params: { member: { email:    @confirmed_member.email,
                                                 password: "password" } }
    assert member_signed_in?
    get root_url
    assert_select "a[href=?]", new_user_registration_path, count:0
    assert_select "a[href=?]", new_user_session_path, count:0
    # assert_select "a[href=?]", edit_user_registration_path
    assert_select "a[href=?]", new_member_session_path, count:0
    assert_select "a[href=?]", destroy_member_session_path
    delete destroy_member_session_path
    follow_redirect!
    assert_select "a[href=?]", new_user_registration_path
    assert_select "a[href=?]", new_user_session_path
    assert_select "a[href=?]", new_member_session_path
    assert_select "a[href=?]", edit_user_registration_path, count:0
    assert_select "a[href=?]", destroy_user_session_path, count:0
  end
end
