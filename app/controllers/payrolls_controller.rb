class PayrollsController < ApplicationController
    include Devise::Controllers::Helpers
    before_action :if_logged_in_member
    before_action :if_logged_in_user

    def new
        @user = User.includes(:members).find(current_user.id)
        Payroll.savecount = @user.members.count
        @form = Form::PayrollCollection.new
    end

    def create
        @user = User.includes(:members).find(current_user.id)
        Payroll.savecount = @user.members.count
        @form = Form::PayrollCollection.new(payroll_collection_params)
        if @form.save
            flash[:success] = "給与データを保存しました"
            redirect_to payroll_show_url
        else
            flash[:alert] = "給与データが保存に失敗しました(※金額部分は空欄で登録できません)"
            render :new
        end
    end

    def destroy
        @user = current_user
        if @user.id == Payroll.find(params[:id]).user_id
            Payroll.find(params[:id]).destroy
            flash[:success] = "給与データを削除しました"
        end
        redirect_to payroll_show_url
    end

    def show
        @user = current_user
        @payroll = Payroll.find(params[:id])
        if @user.id != Payroll.find(params[:id]).user_id
            redirect_to root_url
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

    private
    
    def payroll_collection_params
        params
            .require(:form_payroll_collection)
            .permit(payrolls_attributes: [:user_name, :member_name, :pay_day, :stating_day, :closing_day,
                                        :workday, :paid_holiday, :leave_deduction, :normal_hours, :overtime_hours,
                                        :holiday_hours, :midnight_hours, :late_early,
                                        :allowance_name_1, :allowance_name_2, :allowance_name_3,
                                        :allowance_name_4, :allowance_name_5,
                                        :basic_salary, :overtime_allowance, :holiday_allowance, :midnight_allowance,
                                        :commutation_allowance_tax, :commutation_allowance_nontax,
                                        :allowance_1, :allowance_2, :allowance_3,
                                        :allowance_4, :allowance_5,
                                        :paid_holiday_allowance, :leave_deduction_price, :late_early_price,
                                        :user_id, :member_id,
                                        :availability])
    end
end

