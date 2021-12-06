InstaFurniture::Application.routes.draw do
  get 'sessions/create'

  resources :listings
  # map '/' to be a redirect to '/listings'
  root :to => redirect('/listings')
  # user login
  resources :users

  get 'auth/:provider/callback' => 'sessions#create', :as => 'login'
  get '/mock_login' => 'sessions#create_mock', :as => 'mock_login'
  get '/mock_login/:uid' => 'sessions#create_mock', :as => 'mock_login_with_uid'
  get '/logout' => 'sessions#logout', :as => 'logout'
  get 'auth/failure' => 'sessions#error', :as => 'login_fail'
end
