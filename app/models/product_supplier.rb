class ProductSupplier < ApplicationRecord
  belongs_to :supplier, class_name: 'Supplier'
  belongs_to :product, class_name: 'Product'

  validates_uniqueness_of :product_id, scope: :supplier_id
end
