require 'test_helper'

class UserMembersEditTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Devise::Controllers::Helpers

  def setup
    @user = users(:tanaka)
    @member = members(:member2)
  end

  test "umsuccessful edit" do
    get user_path(@user)
    assert_not flash.empty?
    assert_redirected_to new_user_session_url

    get new_user_session_path
    assert_select "a[href=?]", new_user_session_path
    post user_session_path params: { user: { email:    @user.email,
                                             password: "password" } }
    assert user_signed_in?
    get edit_user_path(@user)
    assert_response :success
    assert_match @user.members[0].name, response.body
    assert_match "出勤日数", response.body

    patch user_path(@user), params: { user: { pay_year: -2020,
                                              pay_month: -10,
                                      members_attributes: { id: @member.id,
                                                            workday: -10,
                                                            paid_holiday: -10,
                                                            leave_deduction: -10,
                                                            normal_hours_h: -10,
                                                            normal_hours_m: -10,
                                                            overtime_hours_h: -10,
                                                            overtime_hours_m: -10,
                                                            holiday_hours_h: -10,
                                                            holiday_hours_m: -10,
                                                            midnight_hours_h: -10,
                                                            midnight_hours_m: -10,
                                                            late_early_h: -10,
                                                            late_early_m: -10 } } }
    assert_select "div.alert", count: 15
    assert_template "users/edit"
    @member.reload
    assert_not @member.workday == -10
  end

  test "successful edit" do
    get user_path(@user)
    assert_not flash.empty?
    assert_redirected_to new_user_session_url

    get new_user_session_path
    assert_select "a[href=?]", new_user_session_path
    post user_session_path params: { user: { email:    @user.email,
                                             password: "password" } }
    assert user_signed_in?
    get edit_user_path(@user)
    assert_response :success
    assert_match @user.members[0].name, response.body
    assert_match "出勤日数", response.body

    patch user_path(@user), params: { user: { pay_year: 2020,
                                              pay_month: 10,
                                      members_attributes: { id: @member.id,
                                                            workday: 10,
                                                            paid_holiday: 10,
                                                            leave_deduction: 10,
                                                            normal_hours_h: 10,
                                                            normal_hours_m: 10,
                                                            overtime_hours_h: 10,
                                                            overtime_hours_m: 10,
                                                            holiday_hours_h: 10,
                                                            holiday_hours_m: 10,
                                                            midnight_hours_h: 10,
                                                            midnight_hours_m: 10,
                                                            late_early_h: 10,
                                                            late_early_m: 10 } } }
    assert_not flash.empty?
    assert_redirected_to user_path(@user)
    follow_redirect!
    @user.reload
    @member.reload
    assert_match "2020", response.body
    assert_equal @member.workday, 10
  end

  test "users edit layout when logged in as member" do
    get new_member_session_path
    assert_select "a[href=?]", new_member_session_path
    post member_session_path params: { member: { email:    @member.email,
                                                 password: "password" } }
    assert member_signed_in?
    get edit_user_path(@user)
    assert_redirected_to root_url
  end
end
