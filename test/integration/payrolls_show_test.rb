require 'test_helper'

class PayrollsShowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Devise::Controllers::Helpers

  def setup
    @user = users(:tanaka)
    @member = members(:member2)
    @payroll = payrolls(:one)
  end

  test "payroll id when logged in as user" do
    get new_user_session_path
    assert_select "a[href=?]", new_user_session_path
    post user_session_path params: { user: { email:    @user.email,
                                             password: "password" } }
    get payroll_path(id: @payroll.id)
    assert_response :success
    assert_match "給与明細", response.body
    assert_match @payroll.member_name, response.body
  end
end
