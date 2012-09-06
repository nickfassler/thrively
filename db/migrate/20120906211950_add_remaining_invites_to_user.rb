class AddRemainingInvitesToUser < ActiveRecord::Migration
  def change
    add_column :users, :remaining_invites, :integer, default: 0, null: false
  end
end
