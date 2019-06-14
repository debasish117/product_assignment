class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :product_uid
      t.decimal :price, precision: 10, scale: 2
      t.text :product_title
      t.boolean :is_active
      t.integer :category_id
      t.timestamps
    end
    add_index :products, :product_uid
    add_index :products, :category_id
  end
end
