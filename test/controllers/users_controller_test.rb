require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

#   有効なユーザーの作成
  def setup
    @user = users(:tanaka)
    # @user.skip_confirmation!
    # @user.save
  end

#   ログインページ
  test "should get user session" do
    get new_user_session_path
    assert_response :success
 
    sign_in @user
    get new_user_session_path
    assert_not flash.empty?
    assert_redirected_to root_url
  end

#   パスワード再設定メール送信ページ
  test "should get user password new" do
    get new_user_password_path
    assert_response :success

    sign_in @user
    get new_user_password_path
    assert_not flash.empty?
    assert_redirected_to root_url
  end

#   パスワード再設定ページ（再設定メールから遷移する先）
  test "should get user password edit" do
    get edit_user_password_path
    assert_not flash.empty?
    assert_redirected_to new_user_session_url

    sign_in @user
    get edit_user_password_path
    assert_not flash.empty?
    assert_redirected_to root_url
  end

#   新規ユーザー登録キャンセルページ
  test "should get user cancel" do
    get cancel_user_registration_path
    assert_redirected_to new_user_registration_url
  end

#   新規ユーザー登録ページ
  test "should get user new" do
    get new_user_registration_path
    assert_response :success
 
    sign_in @user
    get new_user_registration_path
    assert_not flash.empty?
    assert_redirected_to root_url
  end

#   ユーザー設定ページ
  test "should get user edit" do
    get edit_user_registration_path
    assert_not flash.empty?
    assert_redirected_to new_user_session_url

    sign_in @user
    get edit_user_registration_path
    assert_response :success
  end

#   アカウント確認メール再送ページ
  test "should get user confirmation new" do
    get new_user_confirmation_path
    assert_response :success
 
    sign_in @user
    get new_user_confirmation_path
    assert_response :success
  end

#   アカウント確認ページ（確認メールから遷移する先）
  test "should get user confirmation" do
    get user_confirmation_path
    assert_response :success
 
    sign_in @user
    get user_confirmation_path
    assert_response :success
  end

  #   アカウント凍結解除メール再送ページ
  test "should get user unlock new" do
    get new_user_unlock_path
    assert_response :success
 
    sign_in @user
    get new_user_unlock_path
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  #   アカウント凍結解除ページ（確認メールから遷移する先）
  test "should get user unlock" do
    get user_unlock_path
    assert_response :success
 
    sign_in @user
    get user_unlock_path
    assert_not flash.empty?
    assert_redirected_to root_url
  end

end
