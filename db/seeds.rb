require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'largest_us_cities.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  l = Location.new
  l.state = row['state']
  l.city = row['city']
  l.save
end

