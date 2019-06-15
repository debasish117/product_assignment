class AdminDashboardsController < ApplicationController
  def create
    service = CsvParser.new(params[:real_file].tempfile.path)
    response = service.process
    if response
      redirect_to(suppliers_path, notice: 'Upload complete successfully.')
    else
      redirect_to(suppliers_path, notice: service.errors[:message])
    end
  end

  def wipe_data
    Category.destroy_all
    Supplier.delete_all
    redirect_to(suppliers_path, notice: 'Data wiped successfully.')
  end
end
