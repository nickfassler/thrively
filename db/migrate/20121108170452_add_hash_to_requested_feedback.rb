class AddHashToRequestedFeedback < ActiveRecord::Migration
  def change
    add_column :requested_feedbacks, :hash_id, :string
  end
end
