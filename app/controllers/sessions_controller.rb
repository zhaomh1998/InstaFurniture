class SessionsController < ApplicationController
  def create
    # Real user login
    auth = request.env['omniauth.auth']
    User.from_omniauth(auth)

    session['logged_in'] = 1
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
      }
    }
    User.from_omniauth(auth)
    session['logged_in'] = 1
    redirect_to root_path
  end

  def logout
    session['logged_in'] = 0
    redirect_to '/users'
    flash[:notice] = 'Successfully logged out'
  end
end
