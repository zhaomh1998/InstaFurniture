# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

listings = [
  { :name => 'IKEA Side Table',
    :description => 'Free. Must pick up from UWS. Originally purchased from IKEA. https://www.ikea.com/us/en/p/lunnarp-side-table-brown-60399030/',
    :location => '2549 Broadway, New York, NY 10025',
    :purchase_date => '10-Oct-2019',
    :elevator_building => 1,
    :pickup_only => 1,
    :price => 0,
    :image => 'seed-1.jpg',
    :phone => "2128541754",
    :uid => "1"
  },
  {
    :name => 'Ikea Desk',
    :description =>
      "Ikea table, lightly used for only 6 months
43.25” W x 26.5” D x 29” H
Pick up in elevator building

Closest item on Ikea's website is:
https://www.ikea.com/us/en/p/lagkapten-adils-desk-black-brown-black-s49417021/#content",
    :location => '500 West 120th Street, New York, NY 10027',
    :purchase_date => '5-Dec-2020',
    :elevator_building => 0,
    :pickup_only => 1,
    :price => 30,
    :image => 'seed-2.jpg',
    :phone => "2129327722",
    :uid => "2"
  },
  {
    :name => 'Aeron Chair Herman Miller Size B',
    :description => 'The seat is broken and torn and needs to be replaced. Other than that everything is in a good condition. If you are lucky you can buy a seat frame and mesh on ebay for up to $150 and easily install it yourself. There are also spare parts on marketplace for a good price.',
    :location => '400 W 119th St, New York, NY 10027-7109',
    :purchase_date => '15-Jun-2017',
    :elevator_building => 1,
    :pickup_only => 1,
    :price => 140,
    :image => 'seed-3.jpg',
    :phone => "8054392845",
    :uid => "3"
  },
  {
    :name => 'Used Office Chair',
    :description => 'Used home office chair. All functionality still works, height adjustment and lean adjustment.',
    :location => '103 West 107th Street, New York',
    :purchase_date => '20-Nov-2018',
    :elevator_building => 0,
    :pickup_only => 0,
    :price => 25,
    :image => 'seed-4.jpg',
    :phone => "2126635520",
    :uid => "4"
  },
  {
    :name => 'Small Desk for Home Office',
    :description => "Light wood desk with white rims.
Sufficient space for laptop and notepad.
Lightweight so it's convenient and easy to carry and transport.
Clean and very good condition.
32\" width x 32.5\" heigh x 20\" depth.
Pick up only",
    :location => '302 West 102nd Street, New York',
    :purchase_date => '19-Mar-2018',
    :elevator_building => 0,
    :pickup_only => 1,
    :price => 35,
    :image => 'seed-5.jpg',
    :phone => "2128541754",
    :uid => "1"
  },
  {
    :name => 'Target office chair',
    :description => "In good condition. Pickup in UWS",
    :location => '300 West 96th Street, New York',
    :purchase_date => '19-Mar-2017',
    :elevator_building => 1,
    :pickup_only => 1,
    :price => 40,
    :image => 'seed-6.jpg',
    :phone => "2129327722",
    :uid => "2"
  },
  {
    :name => 'MUJI Wooden Full Size Bed Frame',
    :description => "Fits a full size mattress. Nice, sturdy wooden frame first purchased from MUJI in 2015 for $600. See pictured for cosmetic damage from apartment moves. Additional cosmetic damage on the headboard from a puppy on a chewing binge. May come with some dog fur hiding in some spots from aforementioned puppy. Bed is currently disassembled and could likely fit in some cars for pick up. Pick up only.",
    :location => '300 West 125th Street, New York',
    :purchase_date => '19-Mar-2015',
    :elevator_building => 0,
    :pickup_only => 1,
    :price => 100,
    :image => 'seed-7.jpg',
    :phone => "8054392845",
    :uid => "3"
  },
  {
    :name => 'Ikea dresser 4 drawers 40-31-19',
    :description => "Yeah you’re looking at Ikea mom dresser with four drawers good condition all drawers open and close properly.
Size of this dresser is 41 inch height 31 inch wide and an 19 inch depth.
Available for pick up or I can have delivered locally for a small fee",
    :location => '200 West 120th Street, New York',
    :purchase_date => '19-Mar-2019',
    :elevator_building => 1,
    :pickup_only => 0,
    :price => 100,
    :image => 'seed-8.jpg',
    :phone => "2126635520",
    :uid => "4"
  },
  {
    :name => 'Haugsvär Ikea Mattress.',
    :description => "Haugsvär mattress from Ikea. In good condition. Definitely on the soft/comfy side. Let me know if you're interested!",
    :location => '610 West 111th Street, New York',
    :purchase_date => '19-Mar-2018',
    :elevator_building => 1,
    :pickup_only => 1,
    :price => 200,
    :image => 'seed-9.jpg',
    :phone => "2128541754",
    :uid => "1"
  },
  {
    :name => 'IKEA Sofa',
    :description => "Small white sofa with 2 different covers included.
IKEA Klippan Faux Leather Loveseat Sofa
Length: 69”
Width: 35”
Height: 26”",
    :location => '400 West 119th Street, New York',
    :purchase_date => '19-Mar-2018',
    :elevator_building => 1,
    :pickup_only => 1,
    :price => 50,
    :image => 'seed-10.jpg',
    :phone => "2129327722",
    :uid => "2"
  },
  {
    :name => 'Sofa',
    :description => "",
    :location => '615 West 113th Street, New York',
    :purchase_date => '19-Mar-2016',
    :elevator_building => 0,
    :pickup_only => 0,
    :price => 150,
    :image => 'seed-11.jpg',
    :phone => "8054392845",
    :uid => "3"
  },
]

listings.each do |listing|
  entry = Listing.create!(listing.except(:image))
  if listing.has_key?(:image)
    entry.photo.attach(
      io: File.open("db/seed-resources/#{listing[:image]}"),
      filename: listing[:image]
    )
  end
end


users = [
  {
    :provider => "google_oauth2",
    :uid => "1",
    :oauth_token => "0",
    :oauth_expires_at => 9999999999,
    :email => "test1@columbia.edu",
    :first_name => "Test",
    :last_name => "User1",
    :profile_pic => "https://static.vecteezy.com/system/resources/previews/002/318/271/non_2x/user-profile-icon-free-vector.jpg"
  },
  {
    :provider => "google_oauth2",
    :uid => "2",
    :oauth_token => "0",
    :oauth_expires_at => 9999999999,
    :email => "test2@columbia.edu",
    :first_name => "Test",
    :last_name => "User2",
    :profile_pic => "https://static.vecteezy.com/system/resources/previews/002/318/271/non_2x/user-profile-icon-free-vector.jpg"
  },
  {
    :provider => "google_oauth2",
    :uid => "3",
    :oauth_token => "0",
    :oauth_expires_at => 9999999999,
    :email => "test3@columbia.edu",
    :first_name => "Test",
    :last_name => "User3",
    :profile_pic => "https://static.vecteezy.com/system/resources/previews/002/318/271/non_2x/user-profile-icon-free-vector.jpg"
  },
  {
    :provider => "google_oauth2",
    :uid => "4",
    :oauth_token => "0",
    :oauth_expires_at => 9999999999,
    :email => "test4@columbia.edu",
    :first_name => "Test",
    :last_name => "User4",
    :profile_pic => "https://static.vecteezy.com/system/resources/previews/002/318/271/non_2x/user-profile-icon-free-vector.jpg"
  }
]

users.each do |user|
  User.create!(user)
end