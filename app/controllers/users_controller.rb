class UsersController < ApplicationController
    include Devise::Controllers::Helpers
    before_action :if_logged_in_member
    before_action :if_logged_in_user
  
    # GET /resource/edit
    def edit
        @user = User.includes(:members).find(current_user.id)
        # @user = User.find(current_user.id)
    end
  
    # PUT /resource
    def update
        begin
            @user = User.find(current_user.id)
            ActiveRecord::Base.transaction do
                if @user.update!(user_members_params)
                    flash[:success] = "勤怠データを編集しました"
                    redirect_to user_url
                end
            end
        rescue
            render "edit"
        end
    end

    def show
        @user = User.includes(:members).find(current_user.id)
    end


    # def new
    #     @user = User.includes(:members).find(current_user.id)
    # end

    # def create
    #     begin
    #         @user = User.find(current_user.id)
    #         ActiveRecord::Base.transaction do
    #             if @user.create!(payroll_params)
    #                 flash[:success] = "給与データを保存しました"
    #                 redirect_to root_url
    #             end
    #         end
    #     rescue
    #         render "edit"
    #     end
    # end

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

private
    def user_members_params
        params.require(:user).permit(:pay_year, :pay_month, members_attributes: [:id, :workday, :paid_holiday, :leave_deduction,
                                                                                      :normal_hours_h, :normal_hours_m,
                                                                                      :overtime_hours_h, :overtime_hours_m,
                                                                                      :holiday_hours_h, :holiday_hours_m,
                                                                                      :midnight_hours_h, :midnight_hours_m,
                                                                                      :late_early_h, :late_early_m])
    end
    
    # def self.multi_update(members_params)
    #     members_params.to_h.map do |id, member_param|
    #       member = self.find(id)
    #       member.update_attributes!(member_param)
    #     end
    # end
end

