class CreateSuppliers < ActiveRecord::Migration[5.2]
  def change
    create_table :suppliers do |t|
      t.integer :supplier_uid
      t.string :supplier_name
      t.text :description
      t.timestamps
    end
    add_index :suppliers, :supplier_uid
  end
end
