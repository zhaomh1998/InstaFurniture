require 'rails_helper'

RSpec.describe Listing do
  describe "call purchase_date" do
    it "returns listings with the same purchase date" do
      Listing.delete_all
      listing1 = { :name => "listing1", :description => "none", :elevator_building => "yes", :pickup_only => "yes", :purchase_date => "date1" }
      listing2 = { :name => "listing2", :description => "none", :elevator_building => "yes", :pickup_only => "yes", :purchase_date => "date1" }
      Listing.create(listing1)
      Listing.create(listing2)

      result = Listing.similar_listings("date1")
      expect(result.find { |listing| listing[:name] == "listing1" }).to_not be_nil
      expect(result.find { |listing| listing[:name] == "listing2" }).to_not be_nil
    end

    it "doesn't return movies by different purchase dates" do
      Listing.delete_all
      listing1 = { :name => "listing1", :description => "none", :elevator_building => "yes", :pickup_only => "yes", :purchase_date => "date1" }
      listing2 = { :name => "listing1", :description => "none", :elevator_building => "yes", :pickup_only => "yes", :purchase_date => "date2" }
      Listing.create(listing1)
      Listing.create(listing2)

      result = Listing.similar_listings("date1")
      expect(result.find { |listing| listing[:name] == "listing1" }).to_not be_nil
      expect(result.find { |listing| listing[:name] == "listing2" }).to be_nil
    end
  end
end
