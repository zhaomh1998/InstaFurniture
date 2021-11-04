require 'rails_helper'

if RUBY_VERSION >= '2.6.0'
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

RSpec.describe ListingsController, :type => :controller do
  describe "listings" do
    it "shows listings on index page" do
      Listing.delete_all
      listing1 = { :name => "listing1", :description => "lorem", :elevator_building => "true", :pickup_only => "true", :purchase_date => "2017-07-20" }
      listing2 = { :name => "listing2", :description => "ipsum", :elevator_building => "true", :pickup_only => "true", :purchase_date => "2017-07-20" }
      Listing.create(listing1)
      Listing.create(listing2)
      get :index
      expect(response).to render_template("listings/index")
    end

    it "renders listing detail page" do
      Listing.delete_all
      listing1 = { :name => "listing1", :description => "lorem", :elevator_building => "true", :pickup_only => "true", :purchase_date => "2017-07-20" }
      Listing.create(listing1)
      get :show, :id => 1
      expect(response).to render_template("listings/show")
    end
  end

  describe "create new listings" do
    it "renders new listing page" do
      get :new
      expect(response).to render_template("listings/new")
    end

    it "submit listing" do
      Listing.delete_all
      post :create, :listing => { :name => "listing1", :description => "lorem", :elevator_building => "true", :pickup_only => "true", :purchase_date => "2017-07-20" }
      expect(response).to redirect_to listings_path
      expect(flash[:notice]).to match(/listing1 was successfully created./)
    end
  end

  describe "edit existing listings" do
    it "renders the edit page" do
      Listing.delete_all
      listing1 = { :name => "listing1", :description => "ipsum", :elevator_building => "true", :pickup_only => "true", :purchase_date => "2017-07-20" }
      Listing.create(listing1)
      get :edit, :id => 1
      expect(response).to render_template("listings/edit")
    end

    it "submit edits" do
      Listing.delete_all
      listing1 = { :name => "listing1", :description => "lorem", :elevator_building => "true", :pickup_only => "true", :purchase_date => "2017-07-20" }
      Listing.create(listing1)
      get :update, { :id => 1,
                     :listing => { :name => "listing1_updated", :description => "ipsum", :elevator_building => "true", :pickup_only => "true", :purchase_date => "2017-07-20" }
      }
      expect(response).to redirect_to listing_path(1)
      expect(flash[:notice]).to match(/listing1_updated was successfully updated./)
    end
  end

  describe "delete existing listings" do
    it "redirects to the index page" do
      Listing.delete_all
      listing1 = { :name => "listing1", :description => "lorem", :elevator_building => "true", :pickup_only => "true", :purchase_date => "2017-07-20" }
      Listing.create(listing1)
      delete :destroy, :id => 1
      expect(response).to redirect_to listings_path
      expect(flash[:notice]).to match(/Listing 'listing1' deleted./)
    end
  end

end
