InstaFurniture::Application.routes.draw do
  get 'sessions/create'

  resources :listings
  # map '/' to be a redirect to '/listings'
  root :to => redirect('/listings')
  # user login
  resources :users

  # 'auth/:provider/callback' :to => 'sessions#create'
  # get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/:provider/callback' => 'sessions#create', :as => 'login'
  get '/mock_login' => 'sessions#create_mock', :as => 'mock_login'
  get '/logout' => 'sessions#logout', :as => 'logout'
end
