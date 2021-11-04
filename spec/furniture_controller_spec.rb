require 'rails_helper'

if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end


RSpec.describe listings_Controller, :type => :controller do
  describe "GET the index page" do
    it "renders the index page" do
      Listing.delete_all
      listing1 = { :id => 1, :name => "listing1", :description => "none", :elevator_building => "yes", :pickup_only => "yes", :purchase_date => "date" }
      listing2 = { :id => 2, :name => "listing2", :description => "none", :elevator_building => "yes", :pickup_only => "yes", :purchase_date => "date" }
      Listing.create(listing1)
      Listing.create(listing2)
      get :index
      expect(response).to render_template("listings/index")
    end
  end

  describe "GET the detail page for a listing" do
    it "renders the show page" do
      Listing.delete_all
      listing1 = { :id => 1, :name => "listing1", :description => "none", :elevator_building => "yes", :pickup_only => "yes", :purchase_date => "date" }
      Listing.create(listing1)
      get :show, :id => 1
      expect(response).to render_template("listings/show")
    end
  end

  describe "GET the new page" do
    it "renders the new page" do
      get :new
      expect(response).to render_template("listings/new")
    end
  end

  describe "GET the edit page" do
    it "renders the edit page" do
      Listing.delete_all
      listing1 = { :id => 1, :name => "listing1", :description => "none", :elevator_building => "yes", :pickup_only => "yes", :purchase_date => "date" }
      Listing.create(listing1)
      get :edit, :id => 1
      expect(response).to render_template("listings/edit")
    end
  end

  describe "POST a new listing" do
    it "redirects to the index page" do
      Listing.delete_all
      post :create, : => { :id => 1, :name => "listing1", :description => "none", :elevator_building => "yes", :pickup_only => "yes", :purchase_date => "date" }
      expect(response).to redirect_to listings_path
    end
  end

  describe "PUT an existing listing" do
    it "redirects to the show page" do
      Listing.delete_all
      listing1 = { :id => 1, :name => "listing1", :description => "none", :elevator_building => "yes", :pickup_only => "yes", :purchase_date => "date" }
      Listing.create(listing1)
      post :update, :id => 1, :movie => { :id => 1, :name => "listing1_updated", :description => "none", :elevator_building => "yes", :pickup_only => "yes", :purchase_date => "date" }
      expect(response).to redirect_to listing_path(1)
    end
  end

  describe "DELETE an existing listing" do
    it "redirects to the index page" do
      Listing.delete_all
      listing1 = { :id => 1, :name => "listing1", :description => "none", :elevator_building => "yes", :pickup_only => "yes", :purchase_date => "date" }
      Listing.create(listing1)
      delete :destroy, :id => 1
      expect(response).to redirect_to listings_path
    end
  end

  describe "GET search a listing with description" do
    it "returns the similar listings" do
      Listing.delete_all
      # create a movie with director
      listing = { :id => 1, :name => "listing1", :description => "none", :elevator_building => "yes", :pickup_only => "yes", :purchase_date => "date" }
      Listing.create(listing)
      get :search, :id => 1
      expect(response).to render_template("listings/similar_listings")
      puts response
    end
  end
  
  describe "GET search a listing without description" do
    it "renders the index page" do
      Listing.delete_all
      listing = { :id => 2, :name => "listing2", :elevator_building => "yes", :pickup_only => "yes", :purchase_date => "date" }
      Listing.create(listing)
      get :search, :id => 2
      expect(response).to redirect_to "/listings"
    end
  end

end
