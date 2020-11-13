class AddColumnsToPayrolls2 < ActiveRecord::Migration[6.0]
  def change
    add_column :payrolls, :stating_day, :string
    add_column :payrolls, :closing_day, :string
  end
end
