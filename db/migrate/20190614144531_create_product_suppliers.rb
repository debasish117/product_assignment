class CreateProductSuppliers < ActiveRecord::Migration[5.2]
  def change
    create_table :product_suppliers do |t|
      t.integer :product_id
      t.integer :supplier_id
      t.timestamps
    end
    add_index :product_suppliers, :product_id
    add_index :product_suppliers, :supplier_id
  end
end
