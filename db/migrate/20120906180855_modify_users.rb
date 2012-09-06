class ModifyUsers < ActiveRecord::Migration
  def up
    add_column :users, :username, :string
    rename_column :users, :first_name, :name
    remove_column :users, :last_name
  end

  def down
    remove_column :users, :username
    rename_column :users, :name, :first_name
    add_column :users, :last_name, :string
  end
end
