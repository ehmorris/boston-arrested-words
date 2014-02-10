namespace :parse_csv do
  task :populateDatabase => :environment do
    require 'csv'

    csv_text = File.read('public/boston-crime-with-unusual-actions.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Crime.create(row.to_hash).save
    end
  end
end
