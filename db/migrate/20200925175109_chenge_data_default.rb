class ChengeDataDefault < ActiveRecord::Migration[6.0]
  def change
    change_column :members, :normal_hours, :time, default: '2000-01-02 00:00:00'
  end
end
