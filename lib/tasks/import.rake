namespace :import do
  desc "imports CSVs from /app/data"
  task :data => :environment do
    require 'csv'
    CSV.foreach('app/data/merchants.csv', headers: true) do |row|
      id = row[0]
      name = row[1]
      created_at = row[2]
      updated_at = row[3]
      Merchant.create(id: id, name: name, created_at: created_at, updated_at: updated_at)
    end

    CSV.foreach('app/data/customers.csv', headers: true) do |row|
      id = row[0]
      first_name = row[1]
      last_name = row[2]
      created_at = row[3]
      updated_at = row[4]
      Customer.create(id: id, first_name: first_name, last_name: last_name, created_at: created_at, updated_at: updated_at)
    end
  end
end
