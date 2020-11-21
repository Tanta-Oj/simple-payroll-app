require 'test_helper'

class PayrollsDestroyTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Devise::Controllers::Helpers

  def setup
    @user = users(:tanaka)
    @member = members(:member2)
    @payroll = payrolls(:one)
  end

  test "payroll destroy when logged in as user" do
    get new_user_session_path
    assert_select "a[href=?]", new_user_session_path
    post user_session_path params: { user: { email:    @user.email,
                                             password: "password" } }
    get payroll_show_path
    assert_match "支給日選択", response.body
    assert_select "a[href=?]", payroll_show_path
    get payroll_show_path, params: { userid: @user.id, choice: @payroll.pay_day }
    assert_response :success
    assert_match "共通事項", response.body
    assert_match @payroll.member_name, response.body

    assert_difference "Payroll.count", -1 do
      delete payroll_path(id: @payroll.id)
    end
  end
end
