class ImportProduct
  attr_reader :product_title, :product_uid, :price, :category_id, :is_active

  def initialize(args)
    @product_uid = args[:product_uid].to_i
    @product_title = args[:product_title]
    @category_id = args[:category_id]
    @price = args[:price]
    @is_active = args[:is_active]
  end

  def save
    existing_product = Product.find_by(product_uid: product_uid)
    return existing_product if existing_product
    new_product = Product.create(product_params)
    new_product
  rescue => e
    raise e.message
  end

  private

  def product_params
    {
      product_uid: product_uid,
      product_title: product_title,
      category_id: category_id,
      price: price,
      is_active: is_active
    }
  end
end
