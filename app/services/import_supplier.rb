class ImportSupplier
  attr_reader :supplier_name, :supplier_uid

  def initialize(args)
    @supplier_uid = args[:supplier_uid].to_i
    @supplier_name = args[:supplier_name]
  end

  def save
    existing_supplier = Supplier.find_by(supplier_uid: supplier_uid)
    return existing_supplier if existing_supplier
    new_supplier = Supplier.create!(supplier_params)
    new_supplier.build_contact(contact_params)
    new_supplier.save!
    new_supplier
  rescue => e
    raise e.message
  end

  private

  def supplier_params
    {
      supplier_uid: supplier_uid,
      supplier_name: supplier_name,
      description: Faker::Lorem.paragraph
    }
  end

  def contact_params
    {
      city: Faker::Address.city,
      country: Faker::Address.country,
      phone: Faker::PhoneNumber.cell_phone
    }
  end
end
