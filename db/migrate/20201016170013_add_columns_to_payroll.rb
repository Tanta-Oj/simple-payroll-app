class AddColumnsToPayroll < ActiveRecord::Migration[6.0]
  def change
    add_column :payrolls, :availability, :boolean
  end
end
