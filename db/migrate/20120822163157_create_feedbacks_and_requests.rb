class CreateFeedbacksAndRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :user_id
      t.string :subject
      t.text :message

      t.timestamps
    end

    create_table :requested_feedbacks do |t|
      t.integer :request_id
      t.string :email
    end

    create_table :feedbacks do |t|
      t.string :subject
      t.text :plus
      t.text :delta
      t.integer :giver_id
      t.integer :receiver_id
    end
  end
end
