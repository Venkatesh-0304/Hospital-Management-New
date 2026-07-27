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

TOTAL_RECORDS = 3_000_000
BATCH_SIZE = 300

(1..TOTAL_RECORDS).each_slice(BATCH_SIZE) do |batch|
  hospitals = batch.map do
    Hospital.new(
      name: Faker::Address.city,
      admin_email: Faker::Internet.email
    )
  end
  Hospital.import(hospitals)
end
