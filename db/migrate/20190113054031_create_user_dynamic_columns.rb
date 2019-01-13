class CreateUserDynamicColumns < ActiveRecord::Migration[5.2]
  def change
    create_table :user_dynamic_columns do |t|
      t.string :meta_key
      t.string :meta_value
      t.references :user

      t.timestamps
    end
  end
end
