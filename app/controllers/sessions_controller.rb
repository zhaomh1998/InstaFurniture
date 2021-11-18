class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    User.find_or_create_by!(uid: auth[:uid]) do |u|
      u.provider = auth[:provider]
      u.uid = auth[:uid]
      u.oauth_token = auth.credentials.token
      u.oauth_expires_at = Time.at(auth.credentials.expires_at)
    end

    session['logged_in'] = 1
    redirect_to root_path
  end
end
