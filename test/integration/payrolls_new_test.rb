require 'test_helper'

class PayrollsNewTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Devise::Controllers::Helpers

  def setup
    @user = users(:tanaka)
    @member = members(:member2)
    @payroll = payrolls(:one)
  end

  test "payroll new layout when logged in as user" do
    get new_payroll_path
    assert_not flash.empty?
    assert_redirected_to new_user_session_url

    get new_user_session_path
    assert_select "a[href=?]", new_user_session_path
    post user_session_path params: { user: { email:    @user.email,
                                             password: "password" } }
    assert user_signed_in?
    get new_payroll_path
    assert_response :success
    assert_match "支給年月日", response.body
    assert_match "出勤日数", response.body
    assert_match @member.name, response.body
    assert_match "一括登録", response.body
  end

  test "unsuccessful create" do
    get new_user_session_path
    assert_select "a[href=?]", new_user_session_path
    post user_session_path params: { user: { email:    @user.email,
                                             password: "password" } }
    assert user_signed_in?
    get new_payroll_path
    assert_response :success
    assert_no_difference "Payroll.count" do
      post payrolls_path, params: { form_payroll_collection: { payrolls_attributes: { "1" => { user_name: "test user",
                                                                                    member_name: "test member",
                                                                                    pay_day: "a",
                                                                                    stating_day: "",
                                                                                    closing_day: "",
                                                                                    workday: "",
                                                                                    paid_holiday: "",
                                                                                    leave_deduction: "",
                                                                                    normal_hours: "",
                                                                                    overtime_hours: "",
                                                                                    holiday_hours: "",
                                                                                    midnight_hours: "",
                                                                                    late_early: "",
                                                                                    allowance_name_1: "",
                                                                                    allowance_name_2: "",
                                                                                    allowance_name_3: "",
                                                                                    allowance_name_4: "",
                                                                                    allowance_name_5: "",
                                                                                    basic_salary: "invalid",
                                                                                    overtime_allowance: 0,
                                                                                    holiday_allowance: 0,
                                                                                    midnight_allowance: 0,
                                                                                    paid_holiday_allowance: 0,
                                                                                    commutation_allowance_tax: 0,
                                                                                    commutation_allowance_nontax: 0,
                                                                                    leave_deduction_price: 0,
                                                                                    late_early_price: 0,
                                                                                    allowance_1: 0,
                                                                                    allowance_2: 0,
                                                                                    allowance_3: 0,
                                                                                    allowance_4: 0,
                                                                                    allowance_5: 0,
                                                                                    user_id: @user.id,
                                                                                    member_id: @member.id,
                                                                                    availability: true} } } }
    end
    assert_select "div.alert", count: 1
    assert_template "payrolls/new"
  end

  test "successful create" do
    get new_user_session_path
    assert_select "a[href=?]", new_user_session_path
    post user_session_path params: { user: { email:    @user.email,
                                             password: "password" } }
    assert user_signed_in?
    get new_payroll_path
    assert_response :success
    assert_difference "Payroll.count", 1 do
      post payrolls_path, params: { form_payroll_collection: { payrolls_attributes: { "1" => { user_name: "test user",
                                                                                    member_name: "test member",
                                                                                    pay_day: "a",
                                                                                    stating_day: "",
                                                                                    closing_day: "",
                                                                                    workday: "",
                                                                                    paid_holiday: "",
                                                                                    leave_deduction: "",
                                                                                    normal_hours: "",
                                                                                    overtime_hours: "",
                                                                                    holiday_hours: "",
                                                                                    midnight_hours: "",
                                                                                    late_early: "",
                                                                                    allowance_name_1: "",
                                                                                    allowance_name_2: "",
                                                                                    allowance_name_3: "",
                                                                                    allowance_name_4: "",
                                                                                    allowance_name_5: "",
                                                                                    basic_salary: 0,
                                                                                    overtime_allowance: 0,
                                                                                    holiday_allowance: 0,
                                                                                    midnight_allowance: 0,
                                                                                    paid_holiday_allowance: 0,
                                                                                    commutation_allowance_tax: 0,
                                                                                    commutation_allowance_nontax: 0,
                                                                                    leave_deduction_price: 0,
                                                                                    late_early_price: 0,
                                                                                    allowance_1: 0,
                                                                                    allowance_2: 0,
                                                                                    allowance_3: 0,
                                                                                    allowance_4: 0,
                                                                                    allowance_5: 0,
                                                                                    user_id: @user.id,
                                                                                    member_id: @member.id,
                                                                                    availability: true},
                                                                                    "2" => { user_name: "test user",
                                                                                      member_name: "test member",
                                                                                      pay_day: "a",
                                                                                      stating_day: "",
                                                                                      closing_day: "",
                                                                                      workday: "",
                                                                                      paid_holiday: "",
                                                                                      leave_deduction: "",
                                                                                      normal_hours: "",
                                                                                      overtime_hours: "",
                                                                                      holiday_hours: "",
                                                                                      midnight_hours: "",
                                                                                      late_early: "",
                                                                                      allowance_name_1: "",
                                                                                      allowance_name_2: "",
                                                                                      allowance_name_3: "",
                                                                                      allowance_name_4: "",
                                                                                      allowance_name_5: "",
                                                                                      basic_salary: 0,
                                                                                      overtime_allowance: 0,
                                                                                      holiday_allowance: 0,
                                                                                      midnight_allowance: 0,
                                                                                      paid_holiday_allowance: 0,
                                                                                      commutation_allowance_tax: 0,
                                                                                      commutation_allowance_nontax: 0,
                                                                                      leave_deduction_price: 0,
                                                                                      late_early_price: 0,
                                                                                      allowance_1: 0,
                                                                                      allowance_2: 0,
                                                                                      allowance_3: 0,
                                                                                      allowance_4: 0,
                                                                                      allowance_5: 0,
                                                                                      user_id: @user.id,
                                                                                      member_id: @member.id,
                                                                                      availability: false} } } }
    end
    #availability: false は保存されない仕様
    assert_not flash.empty?
    assert_redirected_to payroll_show_url
    follow_redirect!
    
    get payroll_show_path
    assert_match "支給日選択", response.body
    assert_select "a[href=?]", payroll_show_path
    get payroll_show_path, params: { userid: @user.id, choice: "a" }
    assert_response :success
    assert_match "共通事項", response.body
    assert_match "test member", response.body
  end
end
