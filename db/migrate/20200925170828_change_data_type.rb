class ChangeDataType < ActiveRecord::Migration[6.0]
  def change
    change_column :members, :pay_type, 'integer USING CAST(pay_type AS integer)'
    change_column :members, :commutation_type, 'integer USING CAST(commutation_type AS integer)'
  end
end
