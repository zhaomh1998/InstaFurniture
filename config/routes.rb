Rottenpotatoes::Application.routes.draw do
  resources :listings
  # map '/' to be a redirect to '/listings'
  root :to => redirect('/listings')
end
