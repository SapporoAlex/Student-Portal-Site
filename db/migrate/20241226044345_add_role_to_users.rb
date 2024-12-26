class AddRoleToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :role, :string
    add_column :users, :default, :string
    add_column :users, :student, :string
  end
end
