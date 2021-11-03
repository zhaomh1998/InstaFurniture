# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

listings = [
  { :name => 'Levo Monitor',
    :description => 'This is Levo Monitor description',
    :price => 1500.0,
    :post_date => '25-Nov-1992',
    :label => 'monitor'
  },
  { :name => 'Apple Monitor',
    :description => 'This is Apple Monitor description',
    :price => 2000.0,
    :post_date => '25-Nov-1992',
    :label => 'monitor'
  },
  { :name => 'Memory Mattress',
    :description => 'This is Memory Mattress description',
    :price => 800.0,
    :post_date => '26-Oct-1984',
    :label => 'mattress'
  }
]

listings.each do |listing|
  Listing.create!(listing)
end
