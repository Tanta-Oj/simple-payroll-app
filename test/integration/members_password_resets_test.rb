require 'test_helper'

class MembersPasswordResetsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Devise::Controllers::Helpers

  def setup
    ActionMailer::Base.deliveries.clear

    @member = members(:member2)
  end

  test "password resets" do
    get new_member_password_path
    assert_template "members/passwords/new"

    post member_password_path, params: { member: { email: "" } }
    assert_select "div.alert", :count => 1
    assert_template "members/passwords/new"

    post member_password_path, params: { member: { email: @member.email } }
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_redirected_to new_member_session_url

    # dbに保存されているtoeknとメールに添付されるtokenは一致しないのでメールに添付されたtokenを取得する必要がある
    # send_reset_password_instructionsメソッドでreset_password_tokenを再発行してテストしている
    reset_password_token = @member.send_reset_password_instructions
    @member.reload
    get edit_member_password_path(reset_password_token: reset_password_token)
    assert_template "members/passwords/edit"

    put member_password_path, params: { member: { reset_password_token:  reset_password_token,
                                                  password:              "",
                                                  password_confirmation: "" } }
    assert_select "div.alert", count: 1

    new_password = "newpassword"
    put member_password_path, params: { member: { reset_password_token:  reset_password_token,
                                              password:              new_password,
                                              password_confirmation: new_password } }

    @member.reload
    assert_not flash.empty?
    assert_redirected_to root_url
    assert member_signed_in?
    delete destroy_member_session_path
    follow_redirect!
    assert_select "a[href=?]", new_user_registration_path
    assert_select "a[href=?]", new_user_session_path
    assert_select "a[href=?]", new_member_session_path
    assert_select "a[href=?]", edit_user_registration_path, count:0
    assert_select "a[href=?]", destroy_user_session_path, count:0
    get new_member_session_path
    post member_session_path params: { member: { email:    @member.email,
                                                 password: new_password } }
    get root_url
    assert_select "a[href=?]", new_user_registration_path, count:0
    assert_select "a[href=?]", new_user_session_path, count:0
    assert_select "a[href=?]", edit_user_registration_path, count:0
    assert_select "a[href=?]", destroy_user_session_path, count:0
    assert_select "a[href=?]", destroy_member_session_path
  end
end
