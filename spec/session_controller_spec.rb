require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  describe "log in" do

    it "log in as default mock user" do
      get :create_mock
      expect(response).to redirect_to root_path
    end

    it "log in as specified uid" do
      get :create_mock, params: { uid: "1" }
      expect(response).to redirect_to root_path
    end
  end

  describe "log off" do
    it "redirects to log in" do
      get :logout, session: { uid: "1" }
      expect(response).to redirect_to users_path
      expect(session[:uid]).to be_nil
    end
  end

  describe "error" do
    it "redirects to log in" do
      get :error, params: { message: "An error message" }
      expect(response).to redirect_to users_path
      expect(flash[:notice]).to match(/Login failed: An error message/)
    end
  end

  describe "verify email" do
    it "accepts @columbia.edu" do
      auth = {
        :provider => 'google_oauth2',
        :uid => '1000',
        :credentials => {
          :token => 'x',
          :expires_at => 9999999999
        },
        :info => {
          :email => 'test_x@columbia.edu',
          :first_name => 'First',
          :last_name => 'Last',
          :image => 'https://static.vecteezy.com/system/resources/previews/002/318/271/non_2x/user-profile-icon-free-vector.jpg'
        }
      }
      request.env['omniauth.auth'] = auth
      get :create
      expect(response).to redirect_to root_path
    end

    it "accepts @tc.columbia.edu" do
      auth = {
        :provider => 'google_oauth2',
        :uid => '1001',
        :credentials => {
          :token => 'x',
          :expires_at => 9999999999
        },
        :info => {
          :email => 'test_x@tc.columbia.edu',
          :first_name => 'First',
          :last_name => 'Last',
          :image => 'https://static.vecteezy.com/system/resources/previews/002/318/271/non_2x/user-profile-icon-free-vector.jpg'
        }
      }
      request.env['omniauth.auth'] = auth
      get :create
      expect(response).to redirect_to root_path
    end

    it "accepts @barnard.edu" do
      auth = {
        :provider => 'google_oauth2',
        :uid => '1002',
        :credentials => {
          :token => 'x',
          :expires_at => 9999999999
        },
        :info => {
          :email => 'test_x@barnard.edu',
          :first_name => 'First',
          :last_name => 'Last',
          :image => 'https://static.vecteezy.com/system/resources/previews/002/318/271/non_2x/user-profile-icon-free-vector.jpg'
        }
      }
      request.env['omniauth.auth'] = auth
      get :create
      expect(response).to redirect_to root_path
    end

    it "rejects @gmail.com" do
      auth = {
        :provider => 'google_oauth2',
        :uid => '1003',
        :credentials => {
          :token => 'x',
          :expires_at => 9999999999
        },
        :info => {
          :email => 'test_x@gmail.com',
          :first_name => 'First',
          :last_name => 'Last',
          :image => 'https://static.vecteezy.com/system/resources/previews/002/318/271/non_2x/user-profile-icon-free-vector.jpg'
        }
      }
      request.env['omniauth.auth'] = auth
      get :create
      expect(response).to redirect_to users_path
      expect(flash[:notice]).to match(/Login failed: @gmail.com is not a valid Columbia email. InstaFurniture only accepts Columbia users./)
    end

    it "rejects @fakecolumbia.edu" do
      auth = {
        :provider => 'google_oauth2',
        :uid => '1004',
        :credentials => {
          :token => 'x',
          :expires_at => 9999999999
        },
        :info => {
          :email => 'test_x@fakecolumbia.edu',
          :first_name => 'First',
          :last_name => 'Last',
          :image => 'https://static.vecteezy.com/system/resources/previews/002/318/271/non_2x/user-profile-icon-free-vector.jpg'
        }
      }
      request.env['omniauth.auth'] = auth
      get :create
      expect(response).to redirect_to users_path
      expect(flash[:notice]).to match(/Login failed: @fakecolumbia.edu is not a valid Columbia email. InstaFurniture only accepts Columbia users./)
    end

  end
end
