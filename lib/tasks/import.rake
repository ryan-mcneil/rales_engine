namespace :import do
  desc "imports CSVs from /app/data"
  task :data => :environment do
    require 'csv'
    CSV.foreach('app/data/merchants.csv', headers: true) do |row|
      id = row[0]
      name = row[1]
      created_at = row[2]
      updated_at = row[3]
      Merchant.create(name: name)
    end
  end
end
