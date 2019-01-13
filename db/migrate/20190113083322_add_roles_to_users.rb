class AddRolesToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :role_ids, :text, array: true, default: []
  end
end
