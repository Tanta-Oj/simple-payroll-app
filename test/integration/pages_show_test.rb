require 'test_helper'

class PagesShowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @member = members(:member2)
    @user = users(:tanaka)
  end

  test "user show layout when logged in as user" do
    get root_path
    sign_in @user
    get user_show_path
    assert_match @user.email, response.body
    assert_match "給与締日", response.body
    assert_match @user.allowance_1, response.body
    assert_select "a[href=?]", edit_user_registration_path
  end

  test "user show layout when logged in as member" do
    get root_path
    sign_in @member
    get user_show_path
    assert_no_match @user.email, response.body
    assert_match "給与締日", response.body
    assert_match @user.allowance_1, response.body
    assert_select "a[href=?]", edit_user_registration_path, count: 0
  end

  test "member show layout when logged in as member" do
    get root_path
    sign_in @member
    get member_show_path
    assert_match @member.name, response.body
    assert_match "基本給", response.body
    assert_match @user.allowance_1, response.body
  end
end
