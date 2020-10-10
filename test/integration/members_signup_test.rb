require 'test_helper'

class MembersSignupTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Devise::Controllers::Helpers
  include Warden::Test::Helpers

  def setup
    ActionMailer::Base.deliveries.clear

    @user = users(:tanaka)
  end

  test "access membersignup with logoutuser" do
    get root_path
    assert_not user_signed_in?
    get new_member_registration_path
    assert_redirected_to new_user_session_url
  end

  test "invalid signup infromation" do
    get new_user_session_path
    assert_select "a[href=?]", new_user_session_path
    post user_session_path params: { user: { email:    @user.email,
                                             password: "password" } }
    assert user_signed_in?

    get new_member_registration_path
    assert_no_difference "Member.count" do
      post member_registration_path, params: { member: { name:                  "",
                                                         email:                 "member@invalid",
                                                         password:              "foo",
                                                         password_confirmation: "bar",
                                                         user:                  @user } }
    end
    assert_template "members/registrations/new"
    assert_select "div.alert", :count => 3
  end

  test "valid signup information with unconfirmed" do
    get new_user_session_path
    assert_select "a[href=?]", new_user_session_path
    post user_session_path params: { user: { email:    @user.email,
                                             password: "password" } }
    assert user_signed_in?

    get new_member_registration_path
    assert_difference "Member.count", 1 do
      post member_registration_path, params: { member: { name:                  "Example Member",
                                                         email:                 "member@valid.com",
                                                         password:              "password",
                                                         password_confirmation: "password",
                                                         user:                  @user } }
    end
  end

  test "valid signup information with confirmed" do
    get new_user_session_path
    assert_select "a[href=?]", new_user_session_path
    post user_session_path params: { user: { email:    @user.email,
                                             password: "password" } }
    assert user_signed_in?

    get new_member_registration_path
    assert_difference "Member.count", 1 do
      post member_registration_path, params: { member: { name:                  "Example Member",
                                                         email:                 "member@valid.com",
                                                         password:              "password",
                                                         password_confirmation: "password",
                                                         user:                  @user } }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    delete destroy_user_session_path

    member = Member.find_by(email: "member@valid.com")
    get member_confirmation_path(confirmation_token: member.confirmation_token)
    member.reload
    assert_not member.confirmed_at.nil?
    post member_session_path, params: { member: { email:    member.email,
                                                  password: "password" } }
    assert member_signed_in?
  end
end
