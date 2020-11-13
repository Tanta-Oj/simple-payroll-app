class PagesController < ApplicationController
  include Devise::Controllers::Helpers
    # before_action :if_logged_in_user, only: [:payroll_show]
    # before_action :if_logged_in_member, only: [:payroll_show]

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

  def payroll_show
    if user_signed_in?
      @user = User.includes(:members).find(current_user.id)
      @pay_days = Payroll.pluck(:user_id, :pay_day).map{|a| a[current_user.id]}.uniq

      # @payrolls = Payrolls.where(user_id: current_user.id, pay_day: params[:choice])
      # Payroll.userid = @user.id
      @payrolls = Payroll.choice(params[:userid],params[:choice])
      @payrolls = [] if @payrolls == nil
    else
      if member_signed_in?
        @membmer = Member.find(current_member.id)
        @pay_days = Payroll.pluck(:member_id, :pay_day).map{|a| a[current_member.id]}.uniq
        @payrolls = Payroll.choice_m(params[:memberid],params[:choice])
        @payrolls = [] if @payrolls == nil
      else
        flash[:alert] = "ログインしてください"
        redirect_to new_member_session_url
      end
    end
  end

  protected
  def if_logged_in_member
    if member_signed_in?
        flash[:alert] = "スタッフはアクセスできません"
        redirect_to root_url
    end
  end

  def if_logged_in_user
      if user_signed_in?
      else
          flash[:alert] = "管理者としてログインしてください"
          redirect_to new_user_session_url
      end
  end
end
