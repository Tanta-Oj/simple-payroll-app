class AddPaydataToMembers < ActiveRecord::Migration[6.0]
  def change
    add_column :members, :pay_type,           :string
    add_column :members, :basic_pay,          :float
    add_column :members, :overtime_price,     :float
    add_column :members, :holiday_price,      :float
    add_column :members, :midnight_price,     :float
    add_column :members, :commutation_type,   :string
    add_column :members, :commutation_tax,    :float
    add_column :members, :commutation_nontax, :float
    add_column :members, :normal_hours,       :time
    add_column :members, :allowance_1,        :float
    add_column :members, :allowance_2,        :float
    add_column :members, :allowance_3,        :float
    add_column :members, :allowance_4,        :float
    add_column :members, :allowance_5,        :float
  end
end
