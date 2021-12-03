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
    :location => '2549 Broadway, New York, NY 10025',
    :purchase_date => '10-Oct-2019',
    :elevator_building => 1,
    :pickup_only => 1
  },
  {
    :name => 'Electric Kettle, Brentwood',
    :description => 'Brentwood electric kettle, good condition. Speed boiling, auto shut-off, boil-protection. Original
price $37.95. Used two years. Now sell for $10. PICK UP ONLY around 114th st & Broadway.',
    :location => '500 West 120th Street, New York, NY 10027',
    :purchase_date => '5-Dec-2020',
    :elevator_building => 0,
    :pickup_only => 0
  },
  {
    :name => 'Sofa bed with a pull out mattress',
    :description => 'Sofa bed with a pull out mattress between full and queen size, very comfortable and with 3 pillows  - 250$ ( originally 650$)',
    :location => '400 W 119th St, New York, NY 10027-7109',
    :purchase_date => '15-Jun-2018',
    :elevator_building => 1,
    :pickup_only => 1
  },
  {
    :name => 'Wayfair Bench with storage',
    :description => 'very good condition, one year old barely used 60$ (originally 180$)',
    :location => '103 West 107th Street, New York',
    :purchase_date => '20-Nov-2020',
    :elevator_building => 1,
    :pickup_only => 0
  },
  {
    :name => 'Desk and desk chair',
    :description => 'Black Ikea Desk - $35 Way fair desk chair: $40 Prices negotiable! Pick up only!',
    :location => '302 West 102nd Street, New York',
    :purchase_date => '19-Mar-2018',
    :elevator_building => 0,
    :pickup_only => 1
  },
]

listings.each do |listing|
  Listing.create!(listing)
end
