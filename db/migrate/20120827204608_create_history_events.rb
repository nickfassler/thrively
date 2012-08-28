class CreateHistoryEvents < ActiveRecord::Migration
  def change
    create_table :history_events do |t|
      t.string :resource_type, null: false
      t.integer :resource_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
