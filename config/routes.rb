Rails.application.routes.draw do
  # Seller profile related routes
  get 'become_a_seller', to: 'sellers#info', as: :become_a_seller  # Page explaining seller benefits
  get 'new_seller_profile', to: 'sellers#new', as: :new_seller_profile # First step form for creating a seller profile
  post 'create_seller_profile', to: 'sellers#create', as: :create_seller_profile # Handles first step profile creation

  resources :sellers, only: [:show, :edit, :update] do
    member do
      get :occupation_step          # Page for occupation info
      patch :update_occupation_step # Handles occupation step submission

      get :security_step            # Page for security info
      patch :update_security_step   # Handles security step submission

      get :account                  # Display the seller's account/profile
      patch :update_account         # Handle updating the account/profile
    end
  end

  # Devise user authentication routes
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # Language selector
  get 'set_language', to: 'application#set_language', as: :set_language

  # Root route for the site
  root 'posts#index'

  # Post related routes (assuming you're using posts for gigs)
  resources :posts, only: [:index, :new, :create, :show, :edit, :update]
end
