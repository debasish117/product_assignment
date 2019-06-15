class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :phone
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
