class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :email, null: false

      t.datetime :created_at, null: false
    end
  end
end
