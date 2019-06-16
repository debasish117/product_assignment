require 'csv'

namespace :import do

  desc 'Import csv data'
  puts "Specify the directory path form where the file will be imported :"
  dir_path = STDIN.gets.chomp
  puts "Specify the exact file name :"
  file_name = STDIN.gets.chomp
  path = dir_path + '/' + file_name
  task data: :environment do
    service = CsvParser.new(path)
    if service.process
      puts "Importing completed successfully"
    else
      puts "Something went wrong while importing !"
    end
  end

end
