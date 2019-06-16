class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :phone
      t.string :city
      t.string :country
      t.integer :contactable_id
      t.string :contactable_type
      t.timestamps
    end
    add_index :contacts, [:contactable_type, :contactable_id]
  end
end
