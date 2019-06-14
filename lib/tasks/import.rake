require 'csv'

namespace :import do

  desc 'Import csv data'
  path = 'lib/supplier_product_data.csv' # array of data
  task data: :environment do
    service = CsvParser.new(path)
    service.process
  end

end
