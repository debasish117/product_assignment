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
    Product.where(product_uid: product_uid, product_title: product_title, category_id: category_id, price: price, is_active: is_active).first_or_create
  rescue => e
    raise e.message
  end
end
