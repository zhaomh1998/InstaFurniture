# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

listings = [
  { :name => 'Mission Oak II Queen Bookcase Storage Bed',
    :description => 'In decent condition, one slat broken. Very heavy and sturdy bed with storage. Must come pick up!
Will need to partially disassemble to remove from room. Just way too big to fit in my new room. Originally $800.',
    :location => '96th & Broadway',
    :purchase_date => '10-Oct-2019',
    :elevator_building => true,
    :pickup_only => true
  },
  {
    :name => 'Electric Kettle, Brentwood',
    :description => 'Brentwood electric kettle, good condition. Speed boiling, auto shut-off, boil-protection. Original
price $37.95. Used two years. Now sell for $10. PICK UP ONLY around 114th st & Broadway.',
    :location => '114th & Broadway',
    :purchase_date => '5-Dec-2020',
    :elevator_building => false,
    :pickup_only => false
  }
]

listings.each do |listing|
  Listing.create!(listing)
end