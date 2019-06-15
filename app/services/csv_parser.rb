class CsvParser
  require 'csv'

  attr_reader :path, :errors

  REQUIRED_HEADERS = ["id", "product_id", "product_title", "supplier_id", "supplier_name", "price", "category", "is_active"]
  VALID_FILE_TYPES = ["text/csv", "application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"]

  def initialize(path)
    @path = path
    @errors = {}
  end

  # TODO (Debasish) : This can be pushed to background job, but due to time limit, i guess this can be considered in future.

  def process
    return false unless is_valid?
    CSV.foreach(path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
      category = ImportCategory.new(name: row['category']).save
      supplier = ImportSupplier.new(supplier_uid: row['supplier_id'], supplier_name: row['supplier_name']).save
      product = ImportProduct.new(product_uid: row['product_id'], product_title: row['product_title'], price: row['price'], is_active: row['is_active'], category_id: category.id).save
      ProductSupplier.create!(product_id: product.id, supplier_id: supplier.id)
      true
    end
    rescue CSV::MalformedCSVError => e
      errors[:message] = 'Malformed CSV (' + e.message+ ')'
      false
    rescue Errno::ENOENT => e
      errors[:message] = 'Cannot find the file at the given path (' + e.message + ')'
      false
    rescue ArgumentError => e
      errors[:message] = 'has incorrect encoding. It should be UTF-8 (' + e.message+ ')'
      false
    rescue => e
      errors[:message] = e.message
      puts "Error raised: #{e.message}"
      false
  end

  def is_valid?
    # check for valid file type
    file_type = Rack::Mime.mime_type(File.extname(path))
    unless VALID_FILE_TYPES.include?(file_type)
      errors[:message] = "Invalid file, accepted file types are: .csv, .xls, .xlsx"
      return false
    end
    # check for missing required headers
    csv_data = CSV.read(path, { headers: true })
    missing_headers = REQUIRED_HEADERS.reject{|header| csv_data.headers.include?(header)}
    if missing_headers.present?
      errors[:message] = "Missing required headers #{missing_headers.join(', ')}"
      return false
    end
    true
  end

end
