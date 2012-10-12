# This migration comes from ventana (originally 20120905201527)
class CreateVentanaEditableContents < ActiveRecord::Migration
  def change
    create_table :ventana_editable_contents do |t|
      t.string :key
      t.text :value
      t.string :content_type

      t.timestamps
    end
  end
end
