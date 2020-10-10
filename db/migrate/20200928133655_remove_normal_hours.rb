class RemoveNormalHours < ActiveRecord::Migration[6.0]
  def change
    remove_column :members, :normal_hours, :time
  end
end
