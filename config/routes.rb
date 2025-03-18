Rails.application.routes.draw do
  # Seller profile related routes
  get 'become_a_seller', to: 'sellers#info', as: :become_a_seller
  get 'new_seller_profile', to: 'sellers#new', as: :new_seller_profile
  post 'create_seller_profile', to: 'sellers#create', as: :create_seller_profile

  # Seller routes (show, edit, update)
  resources :sellers, only: [:show, :edit, :update] do
    member do
      get :occupation_step            # Seller's occupation step
      patch :update_occupation_step   # Update occupation step
      get :security_step              # Seller's security step
      patch :update_security_step     # Update security step
      get :account                    # Seller account page
      patch :update_account           # Update seller account page
    end
  end

  # Routes for posts (gigs as well)
  resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    member do
      get 'buy', to: 'posts#buy', as: 'buy'
      get 'contact_creator', to: 'posts#contact_creator', as: 'contact_creator'
      post 'send_message', to: 'posts#send_message', as: 'send_message'  # Updated this to route to send_message
      resources :orders, only: [:create]  # Creating an order for a post
    end
  end

  # Routes for gigs (associated posts)
  resources :gigs, only: [:new, :create, :index, :show] do
    resources :posts, only: [:index, :new, :create] # Posts associated with a gig
  end

  # Orders routes for sellers (general orders for sellers)
  resources :orders, only: [:index, :show] do
    member do
      patch 'reply', to: 'orders#reply'  # Seller replying to an order
    end
  end

  # Add a custom route to handle orders for the current user
  resources :users, only: [] do
    resources :orders, only: [:index]  # User-specific orders route
  end

  # Devise user authentication routes (with omniauth)
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # Language selector route
  get 'set_language', to: 'application#set_language', as: :set_language

  # Root route for the site (home page)
  root 'posts#index'
end
