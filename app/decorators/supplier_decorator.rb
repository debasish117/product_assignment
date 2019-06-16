class SupplierDecorator < Draper::Decorator
  delegate_all

  def address
    contact.city + ',' + contact.country
  end

end
