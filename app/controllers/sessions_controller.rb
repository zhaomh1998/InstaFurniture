class SessionsController < ApplicationController
  def create
      @user = User.from_omniauth(@auth)
      @auth = env["omniauth.auth"]
      session[:user_id] = @user.id
      redirect_to root_path
  end
end