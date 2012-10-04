class AddCounterCaches < ActiveRecord::Migration
  def up
    add_column :users, :feedbacks_count, :integer, default: 0, null: false
    add_column :users, :requests_count, :integer, default: 0, null: false
    add_column :users, :invites_count, :integer, default: 0, null: false
    add_column :guests, :feedbacks_count, :integer, default: 0, null: false

    user_ids = select_values('SELECT id FROM users')

    user_ids.each do |user_id|
      feedbacks_count = select_value <<-eosql
        SELECT COUNT(*)
        FROM feedbacks
        WHERE giver_id = #{user_id} AND giver_type = 'User'
      eosql

      requests_count = select_value("SELECT COUNT(*) FROM requests WHERE user_id = #{user_id}")
      invites_count = select_value("SELECT COUNT(*) FROM invites WHERE user_id = #{user_id}")

      update <<-eosql
        UPDATE users
        SET feedbacks_count = #{feedbacks_count},
          requests_count = #{requests_count},
          invites_count = #{invites_count}
        WHERE id = #{user_id}
      eosql
    end

    guest_ids = select_values('SELECT id FROM guests')

    guest_ids.each do |guest_id|
      feedbacks_count = select_value <<-eosql
        SELECT COUNT(*)
        FROM feedbacks
        WHERE giver_id = #{guest_id} AND giver_type = 'Guest'
      eosql

      update <<-eosql
        UPDATE guests
        SET feedbacks_count = #{feedbacks_count}
        WHERE id = #{guest_id}
      eosql
    end
  end

  def down
    remove_column :users, :feedbacks_count
    remove_column :users, :requests_count
    remove_column :users, :invites_count
    remove_column :guests, :feedbacks_count
  end
end
