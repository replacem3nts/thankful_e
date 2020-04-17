require 'csv'
Faker::Config.locale = 'en-US'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'all_us_states.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  l = Location.new
  l.state = row['State']
  l.abbrev = row['Abbrev']
  l.save
end

20.times do
    Category.create(name: Faker::Hipster.word)
end

User.create(username: "Kermit_the_frog", email: "kermit@muppets.com", password: "password123", location_id: rand(1..51), phone: Faker::PhoneNumber.cell_phone)
User.create(username: "Miss_Piggy", email: "misspiggy@muppets.com", password: "password123", location_id: rand(1..51), phone: Faker::PhoneNumber.cell_phone)
User.create(username: "Fozzie_the_Bear", email: "fozzie@muppets.com", password: "password123", location_id: rand(1..51), phone: Faker::PhoneNumber.cell_phone)
User.create(username: "Gonzo", email: "gonzo@muppets.com", password: "password123", location_id: rand(1..51), phone: Faker::PhoneNumber.cell_phone)
User.create(username: "Rowlf_the_Dog", email: "Rowlf@muppets.com", password: "password123", location_id: rand(1..51), phone: Faker::PhoneNumber.cell_phone)
User.create(username: "Scooter", email: "scooter@muppets.com", password: "password123", location_id: rand(1..51), phone: Faker::PhoneNumber.cell_phone)
User.create(username: "ANIMAL", email: "animal@muppets.com", password: "password123", location_id: rand(1..51), phone: Faker::PhoneNumber.cell_phone)
User.create(username: "Rizzo_the_Rat", email: "rizzo@muppets.com", password: "password123", location_id: rand(1..51), phone: Faker::PhoneNumber.cell_phone)
User.create(username: "Statler", email: "statler@muppets.com", password: "password123", location_id: rand(1..51), phone: Faker::PhoneNumber.cell_phone)
User.create(username: "Waldorf", email: "waldorf@muppets.com", password: "password123", location_id: rand(1..51), phone: Faker::PhoneNumber.cell_phone)
User.create(username: "Bunsen_Honeydew", email: "bunsen@muppets.com", password: "password123", location_id: rand(1..51), phone: Faker::PhoneNumber.cell_phone)
User.create(username: "Beaker", email: "beaker@muppets.com", password: "password123", location_id: rand(1..51), phone: Faker::PhoneNumber.cell_phone)
User.create(username: "The_Swedish_Chef", email: "swedechef@muppets.com", password: "password123", location_id: rand(1..51), phone: Faker::PhoneNumber.cell_phone)
User.create(username: "Sam_Eagle", email: "sam_e@muppets.com", password: "password123", location_id: rand(1..51), phone: Faker::PhoneNumber.cell_phone)

30.times do
    Post.create(title: "Thank you to the #{Faker::IndustrySegments.sub_sector.downcase} workers!!", user_id: rand(1..14), content: Faker::Hipster.paragraph(sentence_count: 4), private: Faker::Boolean.boolean(true_ratio: 0.1),location_id: rand(1..51), category_id: rand(1..20))
end

100.times do
    Like.create(user_id: rand(1..14), post_id: rand(1..30))
end