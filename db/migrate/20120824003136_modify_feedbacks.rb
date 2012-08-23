class ModifyFeedbacks < ActiveRecord::Migration
  def up
    add_column :feedbacks, :giver_type, :string
    add_column :feedbacks, :receiver_type, :string
    add_column :feedbacks, :created_at, :datetime, null: false
    add_column :feedbacks, :updated_at, :datetime, null: false
  end

  def down
    remove_column :feedbacks, :giver_type
    remove_column :feedbacks, :receiver_type
    remove_column :feedbacks, :created_at
    remove_column :feedbacks, :updated_at
  end
end
