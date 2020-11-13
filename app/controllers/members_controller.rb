# frozen_string_literal: true

# class MembersController < ActionController::Base
class MembersController < ApplicationController
    include Devise::Controllers::Helpers
    before_action :if_logged_in_member
    before_action :if_logged_in_user
    before_action :logged_in_current_user, only: [:update, :destroy]
  
    # GET /resource/edit
    def edit
    #   @member = Member.find(current_user.members[params[:id]].id)
        @user = current_user
        begin
            member_id = @user.members[params[:id].to_i].id
            @member = Member.find(member_id)
        rescue
            redirect_to root_url
        end
    end
  
    # PUT /resource
    def update
        @user = current_user
        @member = Member.find(params[:id])
        if params[:member][:password].blank?
            params[:member].delete(:password)
            params[:member].delete(:password_confirmation)
        end
        if @member.update(member_params)
            flash[:success] = "スタッフ情報を編集しました"
            redirect_to root_url
        else
            render "edit"
        end
    #   super
    end

    def destroy
        @user = current_user
        if @user.id == Member.find(params[:id]).user_id
            Member.find(params[:id]).destroy
            flash[:success] = "スタッフを削除しました"
        end
        redirect_to root_url
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

    def logged_in_current_user
        if current_user.id == Member.find(params[:id]).user_id
        else
            flash[:alert] = "管理者としてログインしてください"
            redirect_to root_url
        end
    end

private
    def member_params
        params.require(:member).permit(:name, :email, :password, :password_confirmation,
                                       :pay_type, :basic_pay,
                                       :overtime_price, :holiday_price, :midnight_price,
                                       :commutation_type, :commutation_tax, :commutation_nontax,
                                       :scheduled_hours_h, :scheduled_hours_m, :allowance_1, :allowance_2,
                                       :allowance_3, :allowance_4, :allowance_5 )
    end
end
  