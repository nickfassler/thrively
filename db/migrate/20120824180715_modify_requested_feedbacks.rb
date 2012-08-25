class ModifyRequestedFeedbacks < ActiveRecord::Migration
  def up
    change_column_null :requested_feedbacks, :request_id, false

    remove_column :requested_feedbacks, :email

    add_column :requested_feedbacks, :giver_id, :integer, null: false
    add_column :requested_feedbacks, :giver_type, :string, null: false
    add_column :requested_feedbacks, :created_at, :datetime, null: false
    add_column :requested_feedbacks, :updated_at, :datetime, null: false
  end

  def down
    change_column_null :requested_feedbacks, :request_id, true

    add_column :requested_feedbacks, :email, :string

    remove_column :requested_feedbacks, :giver_id
    remove_column :requested_feedbacks, :giver_type
    remove_column :requested_feedbacks, :created_at
    remove_column :requested_feedbacks, :updated_at
  end
end
