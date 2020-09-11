require 'test_helper'

class MembersEditTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Devise::Controllers::Helpers

  def setup
    @user = users(:tanaka)
    @member = members(:member2)
  end

  test "access membersignup with logoutuser" do
    get root_path
    assert_not user_signed_in?
    get edit_member_path(id: 0)
    assert_redirected_to new_user_session_url
  end

  test "unsuccessful edit" do
    get new_user_session_path
    assert_select "a[href=?]", new_user_session_path
    post user_session_path params: { user: { email:    @user.email,
                                             password: "password" } }
    assert user_signed_in?

    # controllerではUser.membersで取得しているので、fixtureで当該userが登録した２番目のmemberなのでid: 1(配列なので0〜)
    get edit_member_path(id: 1)
    assert_template "members/edit"

    new_name = ""
    patch member_path(@member), params: { member: { name: new_name,
                                                    email: @member.email } }
    assert_select "div.alert", count: 1
    assert_template "members/edit"
    @member.reload
    assert_not new_name == @member.name
  end

  test "successful edit" do
    get new_user_session_path
    assert_select "a[href=?]", new_user_session_path
    post user_session_path params: { user: { email:    @user.email,
                                             password: "password" } }
    assert user_signed_in?

    # controllerではUser.membersで取得しているので、fixtureで当該userが登録した２番目のmemberなのでid: 1(配列なので0〜)
    get edit_member_path(id: 1)
    assert_template "members/edit"

    new_name = "new name"
    patch member_path(@member), params: { member: { name: new_name,
                                                    email: @member.email } }
    assert_not flash.empty?
    @member.reload
    assert_equal new_name, @member.name
  end

  test "successful destroy" do
    get new_user_session_path
    assert_select "a[href=?]", new_user_session_path
    post user_session_path params: { user: { email:    @user.email,
                                             password: "password" } }
    assert user_signed_in?

    # controllerではUser.membersで取得しているので、fixtureで当該userが登録した２番目のmemberなのでid: 1(配列なので0〜)
    get edit_member_path(id: 1)
    assert_template "members/edit"

    delete member_path(@member)
    assert_redirected_to root_url

    delete destroy_user_session_path

    get new_member_session_path
    post member_session_path params: { member: { email:    @member.email,
                                                 password: "password" } }
    assert_select "div.alert", count: 1
  end
end
