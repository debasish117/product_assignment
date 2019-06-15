class Product < ApplicationRecord
  has_many :product_suppliers, dependent: :destroy
  has_many :suppliers, through: :product_suppliers, source: 'supplier', dependent: :destroy
  belongs_to :category

  scope :active, ->  { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }
end
