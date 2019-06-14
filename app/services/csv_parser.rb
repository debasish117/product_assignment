class CsvParser
  require 'csv'

  attr_reader :path

  def initialize(path)
    @path = path
  end

  def process
    CSV.foreach(path, headers: true) do |row|
      category = ImportCategory.new(name: row['category']).save
      supplier = ImportSupplier.new(supplier_uid: row['supplier_id'], supplier_name: row['supplier_name']).save
      product = ImportProduct.new(product_uid: row['product_id'], product_title: row['product_title'], price: row['price'], category_id: category.id).save
      ProductSupplier.create!(product_id: product.id, supplier_id: supplier.id)
    end
  end
end
