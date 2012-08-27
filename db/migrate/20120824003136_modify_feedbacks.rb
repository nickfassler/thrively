class ModifyFeedbacks < ActiveRecord::Migration
  def up
    change_column_null :feedbacks, :giver_id, false
    change_column_null :feedbacks, :receiver_id, false

    add_column :feedbacks, :giver_type, :string, null: false
    add_column :feedbacks, :receiver_type, :string, null: false
    add_column :feedbacks, :created_at, :datetime, null: false
    add_column :feedbacks, :updated_at, :datetime, null: false
  end

  def down
    change_column_null :feedbacks, :giver_id, true
    change_column_null :feedbacks, :receiver_id, true

    remove_column :feedbacks, :giver_type
    remove_column :feedbacks, :receiver_type
    remove_column :feedbacks, :created_at
    remove_column :feedbacks, :updated_at
  end
end
