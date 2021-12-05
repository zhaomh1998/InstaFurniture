class SessionsController < ApplicationController
  def create
    # Real user login
    auth = request.env['omniauth.auth']

    # Restrict to @columbia.edu, @*.columbia.edu, @barnard.edu, @*.barnard.edu
    email_domain = auth[:info][:email].split("@").last
    if !/^(.+\.)*columbia.edu$/i.match(email_domain) && !/^(.+\.)*barnard.edu$/i.match(email_domain)
      flash[:notice] = "Login failed: @#{email_domain} is not a valid Columbia email. InstaFurniture only accepts Columbia users."
      redirect_to '/users'
      return
    end

    User.from_omniauth(auth)
    session['uid'] = auth[:uid]
    redirect_to root_path
  end

  def create_mock
    # Mock user login in test
    # TODO: Make sure only test frameworks can do this
    auth = {
      :provider => 'google_oauth2',
      :uid => '116978184920182545388',
      :credentials => {
        :token => 'ya29.a0ARrdaM-p0Kb9_VsGomy-TtHrT7UEl5CoLhJqw1NQ3sA3BbxgGTN1zDoamV80sqxxpHQs-yGCEWPxib4op0VdpOA3a2A6M370VN6nwGNOlQ12jMuWUHVjX9k8SL-tLQvMf1fz0CRg_sI74Inls-4TcoYXXBXm',
        :expires_at => 1637213872
      },
      :info => {
        :email => 'mz2866@columbia.edu',
        :first_name => 'Scott',
        :last_name => 'Zhao',
        :image => 'https://lh3.googleusercontent.com/a-/AOh14GjXlewpIKCuS-1Sx57C0r-Z5oDMEVqgsbfklSnz=s96-c'
      }
    }
    User.from_omniauth(auth)
    session['uid'] = '116978184920182545388'
    redirect_to root_path
  end

  def logout
    if session.has_key?(:uid)
      session.delete(:uid)
    end
    redirect_to '/users'
    flash[:success] = 'Successfully logged out'
  end

  def error
    flash[:notice] = "Login failed: #{params[:message]}"
    redirect_to '/users'
  end
end
