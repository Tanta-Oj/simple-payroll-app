require 'test_helper'

class PayrollTest < ActiveSupport::TestCase
  def setup
    @user = users(:tanaka)
    @member = members(:member2)
    @payroll = payrolls(:one)
  end

  test "should be valid" do
    assert @payroll.valid?
  end

  test "integer should be present" do
    @payroll.basic_salary = ""
    assert_not @payroll.valid?
  end
end
