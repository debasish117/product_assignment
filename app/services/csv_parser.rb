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
    # Adjustment to support different file formats
    (2..parsed_data.last_row).each do |i|
      row = Hash[[get_headers, parsed_data.row(i)].transpose]
      category = ImportCategory.new(name: row['category']).save
      supplier = ImportSupplier.new(supplier_uid: row['supplier_id'], supplier_name: row['supplier_name']).save
      product = ImportProduct.new(product_uid: row['product_id'], product_title: row['product_title'], price: row['price'], is_active: row['is_active'], category_id: category.id).save
      ProductSupplier.create!(product_id: product.id, supplier_id: supplier.id)
      true
    end
    # CSV.foreach(path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
    #   category = ImportCategory.new(name: row['category']).save
    #   supplier = ImportSupplier.new(supplier_uid: row['supplier_id'], supplier_name: row['supplier_name']).save
    #   product = ImportProduct.new(product_uid: row['product_id'], product_title: row['product_title'], price: row['price'], is_active: row['is_active'], category_id: category.id).save
    #   ProductSupplier.create!(product_id: product.id, supplier_id: supplier.id)
    #   true
    # end
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

  private

  def is_valid?
    return valid_file_type? && valid_headers?
  end

  def parsed_data
    @_parsed_data ||= Roo::Spreadsheet.open(path) if valid_file_type?
  end

  def get_headers
    @_headers ||= parsed_data.row(1).compact
  end

  def valid_file_type?
    file_type = Rack::Mime.mime_type(File.extname(path))
    return true if VALID_FILE_TYPES.include?(file_type) # NOTE(self): Returns true and gets out of method if condition is true, else returns false.
    errors[:message] = "Invalid file, accepted file types are: .csv, .xls, .xlsx"
    false
  end

  def valid_headers?
    missing_headers = REQUIRED_HEADERS.reject{|header| get_headers.include?(header)}
    return true unless missing_headers.present? # NOTE(self): Returns true and gets out of method if condition is true, else returns false.
    errors[:message] = "Missing required headers #{missing_headers.join(', ')}"
    false
  end

end
