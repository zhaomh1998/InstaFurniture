require 'rails_helper'

RSpec.describe ListingsController, :type => :controller do

  describe "before log in" do
    it "Redirects index -> log in" do
      get :index
      expect(response).to redirect_to("/users")
      expect(flash[:notice]).to match(/Please log in with columbia.edu email/)
    end

    it "Redirects show -> log in" do
      get :show, params: { id: 1 }
      expect(response).to redirect_to("/users")
      expect(flash[:notice]).to match(/Please log in with columbia.edu email/)
    end

    it "Redirects new -> log in" do
      get :new
      expect(response).to redirect_to("/users")
      expect(flash[:notice]).to match(/Please log in with columbia.edu email/)
    end

    it "Redirects create -> log in" do
      post :create, params: { listing: { :name => "listing1", :description => "lorem", :elevator_building => "true", :pickup_only => "true", :purchase_date => "2017-07-20" } }
      expect(response).to redirect_to("/users")
      expect(flash[:notice]).to match(/Please log in with columbia.edu email/)
    end

    it "Redirects edit -> log in" do
      get :edit, params: { id: 1 }
      expect(response).to redirect_to("/users")
      expect(flash[:notice]).to match(/Please log in with columbia.edu email/)
    end

    it "Redirects update -> log in" do
      get :update, params: { id: 1,
                             listing: { :name => "listing1_updated", :description => "ipsum", :elevator_building => "true", :pickup_only => "true", :purchase_date => "2017-07-20" }
      }
      expect(response).to redirect_to("/users")
      expect(flash[:notice]).to match(/Please log in with columbia.edu email/)
    end

    it "Redirects destroy -> log in" do
      delete :destroy, params: { id: 1 }
      expect(response).to redirect_to("/users")
      expect(flash[:notice]).to match(/Please log in with columbia.edu email/)
    end
  end

  describe "listings" do
    it "shows listings on index page" do
      get :index, session: { uid: "1" }
      expect(response).to render_template("listings/index")
    end

    it "renders listing detail page" do
      get :show, params: { id: 1 }, session: { uid: "1" }
      expect(response).to render_template("listings/show")
    end
  end

  describe "create new listings" do
    it "renders new listing page" do
      get :new, session: { uid: "1" }
      expect(response).to render_template("listings/new")
    end

    it "submit listing" do
      post :create, params: { listing: { :name => "listing1", :description => "lorem", :elevator_building => "true", :pickup_only => "true", :purchase_date => "2017-07-20" } }, session: { uid: "1" }
      expect(response).to redirect_to listings_path
      expect(flash[:success]).to match(/listing1 was successfully created./)
    end
  end

  describe "edit existing listings" do
    it "renders the edit page" do
      # Editing my own listing should succeed
      get :edit, params: { id: 1 }, session: { uid: "1" }
      expect(response).to render_template("listings/edit")

      # Editing someone else's listing should fail and redirect to homepage
      get :edit, params: { id: 2 }, session: { uid: "1" }
      expect(response).to redirect_to listings_path
      expect(flash[:notice]).to match(/Error: You are not allowed to edit someone else's listing!/)
    end

    it "submit edits" do
      # Editing my own listing should succeed
      get :update, params: { id: 1,
                             listing: { :name => "listing1_updated", :description => "ipsum", :elevator_building => "true", :pickup_only => "true", :purchase_date => "2017-07-20" }
      }, session: { uid: "1" }
      expect(response).to redirect_to listing_path(1)
      expect(flash[:success]).to match(/listing1_updated was successfully updated./)

      # Editing someone else's listing should fail and redirect to homepage
      get :update, params: { id: 2,
                             listing: { :name => "listing2_updated", :description => "ipsum", :elevator_building => "true", :pickup_only => "true", :purchase_date => "2017-07-20" },
      }, session: { uid: "1" }
      expect(response).to redirect_to listings_path
      expect(flash[:notice]).to match(/Error: You are not allowed to edit someone else's listing!/)
    end
  end

  describe "delete existing listings" do
    it "redirects to the index page" do
      # Deleting my own listing should succeed
      delete :destroy, params: { id: 1 }, session: { uid: "1" }
      expect(response).to redirect_to listings_path
      expect(flash[:success]).to match(/Listing 'IKEA Side Table' deleted./)

      # Deleting someone else's listing should fail
      delete :destroy, params: { id: 2 }, session: { uid: "1" }
      expect(response).to redirect_to listings_path
      expect(flash[:notice]).to match(/Error: You are not allowed to delete someone else's listing!/)
    end
  end

  describe "search and filter listings" do
    it "search with 2 results" do
      get :index, params: { query: "desk", filter_pick_up: "1", filter_deliver: "1" }, session: { uid: "1" }
      expect(response).to render_template("listings/index")
    end

    it "search with 1 results" do
      get :index, params: { query: "dresser", filter_pick_up: "1", filter_deliver: "1" }, session: { uid: "1" }
      expect(response).to render_template("listings/index")
    end

    it "search with no result" do
      get :index, params: { query: "ThisIsNotInAnyListing", filter_pick_up: "1", filter_deliver: "1" }, session: { uid: "1" }
      expect(response).to render_template("listings/index")
    end

    it "filter deliver with 3 results" do
      get :index, params: { query: "", filter_deliver: "1" }, session: { uid: "1" }
      expect(response).to render_template("listings/index")
    end

    it "filter pick_up with 2 results" do
      get :index, params: { query: "desk", filter_pick_up: "1" }, session: { uid: "1" }
      expect(response).to render_template("listings/index")
    end

    it "filter elevator with 6 results" do
      get :index, params: { query: "", filter_pick_up: "1", filter_deliver: "1", filter_elevator: "1" }, session: { uid: "1" }
      expect(response).to render_template("listings/index")
    end

    it "filter my listings with 3 results" do
      get :index, params: { filter_my_listings: "1" }, session: { uid: "1" }
      expect(response).to render_template("listings/index")
    end
  end
end
