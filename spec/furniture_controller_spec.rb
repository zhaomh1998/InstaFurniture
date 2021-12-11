require 'rails_helper'

RSpec.describe ListingsController, :type => :controller do
  describe "listings" do
    it "shows listings on index page" do
      get :index
      expect(response).to render_template("listings/index")
    end

    it "renders listing detail page" do
      get :show, params: { id: 1 }
      expect(response).to render_template("listings/show")
    end
  end

  describe "create new listings" do
    it "renders new listing page" do
      get :new
      expect(response).to render_template("listings/new")
    end

    it "submit listing" do
      post :create, params: { listing: { :name => "listing1", :description => "lorem", :elevator_building => "true", :pickup_only => "true", :purchase_date => "2017-07-20" } }
      expect(response).to redirect_to listings_path
      expect(flash[:success]).to match(/listing1 was successfully created./)
    end
  end

  describe "edit existing listings" do
    it "renders the edit page" do
      # Editing my own listing should succeed
      get :edit, params: { id: 1 }
      expect(response).to render_template("listings/edit")

      # Editing someone else's listing should fail and redirect to homepage
      get :edit, params: {id: 2}
      expect(response).to redirect_to listings_path
      expect(flash[:notice]).to match(/Error: You are not allowed to edit someone else's listing!/)
    end

    it "submit edits" do
      # Editing my own listing should succeed
      get :update, params: { id: 1,
                             listing: { :name => "listing1_updated", :description => "ipsum", :elevator_building => "true", :pickup_only => "true", :purchase_date => "2017-07-20" }
      }
      expect(response).to redirect_to listing_path(1)
      expect(flash[:success]).to match(/listing1_updated was successfully updated./)

      # Editing someone else's listing should fail and redirect to homepage
      get :update, params: { id: 2,
                             listing: { :name => "listing2_updated", :description => "ipsum", :elevator_building => "true", :pickup_only => "true", :purchase_date => "2017-07-20" }
      }
      expect(response).to redirect_to listings_path
      expect(flash[:notice]).to match(/Error: You are not allowed to edit someone else's listing!/)
    end
  end

  describe "delete existing listings" do
    it "redirects to the index page" do
      # Deleting my own listing should succeed
      delete :destroy, params: { id: 1 }
      expect(response).to redirect_to listings_path
      expect(flash[:success]).to match(/Listing 'IKEA Side Table' deleted./)

      # Deleting someone else's listing should fail
      delete :destroy, params: { id: 2 }
      expect(response).to redirect_to listings_path
      expect(flash[:notice]).to match(/Error: You are not allowed to delete someone else's listing!/)
    end
  end

end
