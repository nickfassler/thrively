class CreateInvites < ActiveRecord::Migration
  def up
    create_table :invites do |t|
      t.timestamps
      t.integer :user_id, null: false
      t.string :email, null: false
      t.string :token, null: false
    end
  end

  def down
    drop_table :invites
  end
end
