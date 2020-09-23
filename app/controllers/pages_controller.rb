class PagesController < ApplicationController
  def home
    if user_signed_in?
      @user = current_user
      @members = @user.members
    end
    if member_signed_in?
      @member = current_member
      @user = User.find(@member.user_id)
      @members = @user.members
    end
  end

  def user_show
    if user_signed_in? || member_signed_in?
      if user_signed_in?
        @user = current_user
      end
      if member_signed_in?
        @member = current_member
        @user = User.find(@member.user_id)
      end
    else
      flash[:alert] = "ログインしてください"
      redirect_to new_member_session_url
    end
  end

  def member_show
    if member_signed_in?
      @member = current_member
      @user = User.find(@member.user_id)
    else
      flash[:alert] = "スタッフとしてログインしてください"
      redirect_to new_member_session_url
    end
  end

  def hinan
    render "shared/_header"
  end
end
