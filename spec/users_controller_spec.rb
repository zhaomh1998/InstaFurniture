require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "log in" do
    it "renders log in page" do
      get :index
      expect(response).to render_template("users/index")
    end
  end
end
