class Supplier < ApplicationRecord
  has_many :product_suppliers, dependent: :destroy
  has_many :products, through: :product_suppliers, source: 'product', dependent: :destroy
  has_one :contact, as: :contactable

  validates :supplier_uid, presence: true 
end
