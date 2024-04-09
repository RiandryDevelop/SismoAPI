require_relative './config/environment'

puts "Deleting all records from the table..."
Comment.delete_all
Feature.delete_all

puts "Refilling the table..."
system("rails fetch_sismo_data:fetch")

puts "Process completed."