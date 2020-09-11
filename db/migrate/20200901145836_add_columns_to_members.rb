class AddColumnsToMembers < ActiveRecord::Migration[6.0]
  def change
    add_column :members, :name, :string
    add_column :members, :user_id, :integer
  end
end
