class Product < ApplicationRecord
  has_many :product_suppliers, dependent: :destroy
  has_many :suppliers, through: :product_suppliers, source: 'supplier'
  belongs_to :category
end
