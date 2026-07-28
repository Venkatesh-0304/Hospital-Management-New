# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# 1000.times do
#   Hospital.create!(name: "#{Faker::Address.city} Hospital", admin_email: "#{Faker::Internet.email}")
# end
require "benchmark"
TOTAL_RECORDS = 3000000
BATCH_SIZE = 3000

  time = Benchmark.realtime do
    (TOTAL_RECORDS / BATCH_SIZE).times do |i|
      hospitals = []

      BATCH_SIZE.times do
        hospitals << Hospital.new(
          name: "#{Faker::Address.city} Hospital",
          address: Faker::Address.full_address,
          admin_email: Faker::Internet.unique.email
        )
      end

      batch_time = Benchmark.realtime do
        Hospital.import(hospitals)
      end

      puts "Batch #{i + 1}: #{BATCH_SIZE} records imported in #{batch_time.round(2)} seconds"
    end
  end

puts "Finished creating #{TOTAL_RECORDS} hospitals"
puts "Time taken: #{time.round(2)} seconds"
