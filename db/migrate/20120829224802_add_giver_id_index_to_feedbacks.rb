class AddGiverIdIndexToFeedbacks < ActiveRecord::Migration
  def change
    add_index :feedbacks, :giver_id
  end
end
