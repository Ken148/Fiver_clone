Rails.application.routes.draw do
  # Seller profile related routes
  get 'become_a_seller', to: 'sellers#info', as: :become_a_seller
  get 'new_seller_profile', to: 'sellers#new', as: :new_seller_profile
  post 'create_seller_profile', to: 'sellers#create', as: :create_seller_profile

  resources :sellers, only: [:show, :edit, :update] do
    member do
      get :occupation_step          
      patch :update_occupation_step 

      get :security_step            
      patch :update_security_step   

      get :account                    # Seller account page
      patch :update_account           # Update seller account
    end
  end

  # Routes for posts (gigs as well)
  resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    # Add the buy action route here
    member do
      get 'buy', to: 'posts#buy', as: 'buy'
      get 'contact_creator', to: 'posts#contact_creator', as: 'contact_creator'  # This is the correct route for contacting the creator
      post 'send_message', to: 'posts#send_message', as: 'send_message'  # Correct POST route for sending a message to the creator
    end
  end

  # Routes for gigs
  resources :gigs, only: [:new, :create, :index, :show] do
    # Nested posts under gigs
    resources :posts, only: [:index, :new, :create] # Posts associated with a gig
  end

  # Devise user authentication routes
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # Language selector route
  get 'set_language', to: 'application#set_language', as: :set_language

  # Root route for the site
  root 'posts#index'
end
