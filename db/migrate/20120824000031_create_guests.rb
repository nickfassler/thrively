class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :email, null: false

      t.timestamps
    end
  end
end
