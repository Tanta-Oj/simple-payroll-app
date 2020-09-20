require 'test_helper'

class PagesMemberShowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @member = members(:member2)
  end

  test "member show layout when logged in as member" do
    get root_path
    sign_in @member
    get member_show_path
    assert_match @member.name, response.body
    assert_match "基本給", response.body
  end
end
