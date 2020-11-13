class RemovePaidholidaypriceToMembers < ActiveRecord::Migration[6.0]
  def change
    remove_column :members, :paid_holiday_price, :float
  end
end
