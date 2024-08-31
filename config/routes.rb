Rails.application.routes.draw do

  post 'users/sign_in', to: 'users#sign_in'
  post 'users', to: 'users#create' # For user registration
  delete 'users/sign_out', to: 'users#sign_out' # If you have a sign_out action

  # Routes for posts, comments, and tags
  resources :posts do
    resources :comments
  end
  
  resources :tags, only: [:index]
  
  # Fallback route for unmatched routes to handle 404 errors
  match '*unmatched', to: 'application#route_not_found', via: :all
end
