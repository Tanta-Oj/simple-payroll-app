require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:tanaka)
    @member = members(:member2)
  end

  test "should get home" do
    get root_path
    assert_response :success
  end

  test "should cant't get user show" do
    get user_show_path
    assert_not flash.empty?
    assert_redirected_to new_member_session_url
  end

  test "should get user show when logged in as user" do
    get root_path
    sign_in @user
    get user_show_path
    assert_response :success
  end

  test "should get user show when logged in as member" do
    get root_path
    sign_in @member
    get user_show_path
    assert_response :success
  end

  test "should cant't get member show" do
    get member_show_path
    assert_not flash.empty?
    assert_redirected_to new_member_session_url

    sign_in @user
    get member_show_path
    assert_not flash.empty?
    assert_redirected_to new_member_session_url
  end

  test "should get member show" do
    get root_path
    sign_in @member
    get member_show_path
    assert_response :success
  end

end
