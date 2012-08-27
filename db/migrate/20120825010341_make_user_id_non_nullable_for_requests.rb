class MakeUserIdNonNullableForRequests < ActiveRecord::Migration
  def up
    change_column_null :requests, :user_id, false
  end

  def down
    change_column_null :requests, :user_id, true
  end
end
