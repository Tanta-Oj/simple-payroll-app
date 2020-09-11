require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  def setup
    @user = users(:tanaka)
    @member = Member.new(name: "Example User", email: "user@example.com",
                         password: "foobar", password_confirmation: "foobar", user: @user)
  end

  test "should be valid" do
    assert @member.valid?
  end

  test "name should be present" do
    @member.name = "     "
    assert_not @member.valid?
  end

  test "name should be too long" do
    @member.name = "a" * 31
    assert_not @member.valid?
  end
end
