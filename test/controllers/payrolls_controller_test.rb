require 'test_helper'

class PayrollsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:tanaka)
    @member = members(:member2)
    @payroll = payrolls(:one)
  end

  test "should can't get payroll" do
    get payroll_path(id: @payroll.id)
    assert_not flash.empty?
    assert_redirected_to new_user_session_url
  end

  test "should get payroll when logged in as user" do
    get root_path
    sign_in @user
    get payroll_path(id: @payroll.id)
    assert_response :success
  end

  test "should get payroll when logged in as member" do
    get root_path
    sign_in @member
    get payroll_path(id: @payroll.id)
    assert_not flash.empty?
    assert_redirected_to root_url
  end
end
