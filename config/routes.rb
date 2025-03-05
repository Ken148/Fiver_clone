Rails.application.routes.draw do
  # Seller profile related routes
  get 'become_a_seller', to: 'sellers#info'  # Page explaining seller benefits
  get 'new_seller_profile', to: 'sellers#new'  # First step form for creating seller profile
  post 'create_seller_profile', to: 'sellers#create'  # Handles first step profile creation

  # Step routes for seller profile creation
  resources :sellers, only: [:new, :create] do
    member do
      # Profile creation steps
      get :occupation_step          # Page for occupation info
      patch :update_occupation_step # Handles occupation step submission

      get :security_step            # Page for security info
      patch :update_security_step   # Handles security step submission

      # Gig creation step
      get :create_gig_step          # Page for creating a gig
      patch :update_create_gig_step # Handles gig creation submission

      # Account/Profile Page: View and Edit Seller Info
      get :account                  # Display the seller's account/profile
      patch :update_account         # Handle updating the account/profile
    end
  end

  # Devise user authentication routes
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # Root route for the site
  root 'posts#index'

  # Post related routes (assuming you're using posts for gigs)
  resources :posts, only: [:index, :new, :create, :show, :edit, :update]
end
