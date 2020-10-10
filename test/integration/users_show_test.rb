require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Devise::Controllers::Helpers

  def setup
    @user = users(:tanaka)
    @member = members(:member2)
  end

  test "users show layout when logged in as user" do
    get user_path(@user)
    assert_not flash.empty?
    assert_redirected_to new_user_session_url

    get new_user_session_path
    assert_select "a[href=?]", new_user_session_path
    post user_session_path params: { user: { email:    @user.email,
                                             password: "password" } }
    assert user_signed_in?
    get user_path(@user)
    assert_response :success
    assert_match @user.members[0].name, response.body
    assert_match "出勤日数", response.body
    assert_select "a[href=?]", edit_user_path(@user)
  end

  test "users show layout when logged in as member" do
    get new_member_session_path
    assert_select "a[href=?]", new_member_session_path
    post member_session_path params: { member: { email:    @member.email,
                                                 password: "password" } }
    assert member_signed_in?
    get user_path(@user)
    assert_redirected_to root_url
  end
end
