class AddRequestIdToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :request_id, :integer

    add_index :feedbacks, :request_id
    add_index :feedbacks, :receiver_id
    add_index :feedbacks, :receiver_type
    add_index :feedbacks, :giver_type
  end
end
