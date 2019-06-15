class ImportCategory
  attr_reader :name

  def initialize(args)
    @name = args[:name]
  end

  def save
    Category.where(name: name).first_or_create
  rescue => e
    raise e.message
  end
end
