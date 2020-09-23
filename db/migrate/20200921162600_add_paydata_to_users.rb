class AddPaydataToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :closing_date, :integer
    add_column :users, :payday, :integer
    add_column :users, :basic_daily, :float
    add_column :users, :allowance_1, :string
    add_column :users, :allowance_2, :string
    add_column :users, :allowance_3, :string
    add_column :users, :allowance_4, :string
    add_column :users, :allowance_5, :string
  end
end
