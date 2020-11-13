class CreatePayrolls < ActiveRecord::Migration[6.0]
  def change
    create_table :payrolls do |t|
      t.string :user_name
      t.string :member_name
      t.string :pay_day
      t.string :workday
      t.string :paid_holiday
      t.string :leave_deduction
      t.string :normal_hours
      t.string :overtime_hours
      t.string :holiday_hours
      t.string :midnight_hours
      t.string :late_early
      t.string :allowance_name_1
      t.string :allowance_name_2
      t.string :allowance_name_3
      t.string :allowance_name_4
      t.string :allowance_name_5
      t.integer :basic_salary
      t.integer :overtime_allowance
      t.integer :holiday_allowance
      t.integer :midnight_allowance
      t.integer :commutation_allowance_tax
      t.integer :commutation_allowance_nontax
      t.integer :allowance_1
      t.integer :allowance_2
      t.integer :allowance_3
      t.integer :allowance_4
      t.integer :allowance_5
      t.integer :user_id
      t.integer :member_id

      t.timestamps
    end
  end
end
