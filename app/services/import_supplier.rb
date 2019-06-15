class ImportSupplier
  attr_reader :supplier_name, :supplier_uid

  def initialize(args)
    @supplier_uid = args[:supplier_uid].to_i
    @supplier_name = args[:supplier_name]
  end

  def save
    Supplier.where(supplier_uid: supplier_uid, supplier_name: supplier_name).first_or_create
  rescue => e
    raise e.message
  end
end
