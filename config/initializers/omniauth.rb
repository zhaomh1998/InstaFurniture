Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.allowed_request_methods = [:post, :get]
  if ENV.has_key?("DEVELOPMENT")
    puts "OAuth set up for development"
    provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], {
      redirect_uri: "http://localhost:3000/auth/google_oauth2/callback"
    }
  else
    puts "OAuth set up for production"
    provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], {
      redirect_uri: "https://evening-atoll-94372.herokuapp.com/auth/google_oauth2/callback"
    }
  end
end
