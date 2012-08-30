class RenameSubjectToTopic < ActiveRecord::Migration
  def up
    rename_column :feedbacks, :subject, :topic
    rename_column :requests, :subject, :topic
  end

  def down
    rename_column :feedbacks, :topic, :subject
    rename_column :requests, :topic, :subject
  end
end
