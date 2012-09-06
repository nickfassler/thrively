class AddOwnerToHistoryEvents < ActiveRecord::Migration
  def up
    add_column :history_events, :owner_type, :string
    execute("UPDATE history_events SET owner_type='User'")
    change_column_null :history_events, :owner_type, false
    rename_column :history_events, :user_id, :owner_id
  end

  def down
    remove_column :history_events, :owner_type
    rename_column :history_events, :owner_id, :user_id
  end
end
