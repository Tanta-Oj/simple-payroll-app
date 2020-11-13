class AddColumnsToPayrolls < ActiveRecord::Migration[6.0]
  def change
    add_column :payrolls, :paid_holiday_allowance, :integer
    add_column :payrolls, :leave_deduction_price, :integer
    add_column :payrolls, :late_early_price, :integer
    add_column :members, :paid_holiday_price, :float
  end
end
