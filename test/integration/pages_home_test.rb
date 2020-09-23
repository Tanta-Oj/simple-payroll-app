require 'test_helper'

class PagesHomeTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:tanaka)
    @member = members(:member2)
  end

  test "home layout when logged in as user" do
    get root_path
    sign_in @user
    get root_path
    assert_match @member.name, response.body
    assert_match "基本給", response.body
    assert_match "編集", response.body
    assert_match @user.allowance_1, response.body
    assert_select "a[href=?]", edit_member_path(id: 1)
  end

  test "home layout when logged in as member" do
    get root_path
    sign_in @member
    get root_path
    assert_match @member.name, response.body
    assert_no_match "基本給", response.body
    assert_no_match "編集", response.body
    assert_no_match @user.allowance_1, response.body
    assert_select "a[href=?]", edit_member_path(id: 1), count: 0
  end

  test "home layout when logged out" do
    get root_path
    assert_no_match @member.name, response.body
    assert_no_match "基本給", response.body
    assert_no_match "編集", response.body
    assert_select "a[href=?]", edit_member_path(id: 1), count: 0
  end
end
