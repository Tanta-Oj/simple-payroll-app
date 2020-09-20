require 'test_helper'

class MembersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

#   有効なユーザーの作成
  def setup
    @user = users(:tanaka)
    @member = members(:member2)
  end

#   ログインページ
  test "should get member session" do
    get new_member_session_path
    assert_response :success
 
    sign_in @member
    get new_member_session_path
    assert_not flash.empty?
    assert_redirected_to root_url
  end

#   パスワード再設定メール送信ページ
  test "should get member password new" do
    get new_member_password_path
    assert_response :success

    sign_in @member
    get new_member_password_path
    assert_not flash.empty?
    assert_redirected_to root_url
  end

#   パスワード再設定ページ（再設定メールから遷移する先）
  test "should get member password edit" do
    get edit_member_password_path
    assert_not flash.empty?
    assert_redirected_to new_member_session_url

    sign_in @member
    get edit_member_password_path
    assert_not flash.empty?
    assert_redirected_to root_url
  end

#   新規ユーザー登録ページ
  test "should can't get member new" do
    get new_member_registration_path
    assert_not flash.empty?
    assert_redirected_to new_user_session_url
 
    sign_in @member
    assert_not flash.empty?
    assert_redirected_to new_user_session_url
  end

  test "should get member new" do
    get root_path
    sign_in @user
    get new_member_registration_path
    assert_response :success
  end

#   ユーザー設定ページ
  test "should can't get member edit" do
    get edit_member_path(id: 1)
    assert_not flash.empty?
    assert_redirected_to new_user_session_url

    sign_in @member
    get edit_member_path(id: 1)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should get member edit" do
    get root_path
    sign_in @user
    get edit_member_path(id: 1)
    assert_response :success
  end

#   アカウント確認メール再送ページ
  test "should get member confirmation new" do
    get new_member_confirmation_path
    assert_response :success
 
    sign_in @member
    get new_member_confirmation_path
    assert_response :success
  end

#   アカウント確認ページ（確認メールから遷移する先）
  test "should get member confirmation" do
    get member_confirmation_path
    assert_response :success
 
    sign_in @member
    get member_confirmation_path
    assert_response :success
  end

  #   アカウント凍結解除メール再送ページ
  test "should get member unlock new" do
    get new_member_unlock_path
    assert_response :success
 
    sign_in @member
    get new_member_unlock_path
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  #   アカウント凍結解除ページ（確認メールから遷移する先）
  test "should get member unlock" do
    get member_unlock_path
    assert_response :success
 
    sign_in @member
    get member_unlock_path
    assert_not flash.empty?
    assert_redirected_to root_url
  end

end
