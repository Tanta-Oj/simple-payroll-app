class AddTimeColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :users,   :pay_year,          :integer
    add_column :users,   :pay_month,         :integer
    add_column :members, :scheduled_hours_h, :integer
    add_column :members, :scheduled_hours_m, :integer
    add_column :members, :workday,           :float
    add_column :members, :paid_holiday,      :float
    add_column :members, :leave_deduction,   :float
    add_column :members, :normal_hours_h,    :integer
    add_column :members, :normal_hours_m,    :integer
    add_column :members, :overtime_hours_h,  :integer
    add_column :members, :overtime_hours_m,  :integer
    add_column :members, :holiday_hours_h,   :integer
    add_column :members, :holiday_hours_m,   :integer
    add_column :members, :midnight_hours_h,  :integer
    add_column :members, :midnight_hours_m,  :integer
    add_column :members, :late_early_h,      :integer
    add_column :members, :late_early_m,      :integer
  end
end
