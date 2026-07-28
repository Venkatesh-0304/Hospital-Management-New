namespace :hospital do
  desc "Generate hospitals"

  task import: :environment do
    puts "Import started"

    TOTAL_RECORDS = 300_000
    BATCH_SIZE = 30_000

    t1 = Time.now

    (1..TOTAL_RECORDS).each_slice(BATCH_SIZE) do |batch|
      hospitals = batch.map do
        Hospital.new(
          name: Faker::Address.city,
          admin_email: Faker::Internet.email,
          address: Faker::Address.street_address
        )
      end

      Hospital.import(hospitals)

      puts "Inserted #{batch.last} hospitals"
    end

    t2 = Time.now

    puts "Completed in #{(t2 - t1).round(2)} seconds"
  end
end
