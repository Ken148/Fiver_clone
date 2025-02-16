Rails.application.routes.draw do
  get 'become_a_seller', to: 'sellers#info'  # Page explaining seller benefits
  get 'new_seller_profile', to: 'sellers#new'  # First step form
  post 'create_seller_profile', to: 'sellers#create'  # Handles first step submission

  resources :sellers, only: [:new, :create] do
    member do
      get :occupation_step  # Page for occupation info
      patch :update_occupation_step  # Handles occupation step submission

      get :security_step  # Page for security info
      patch :update_security_step  # Handles security step submission

      get :create_gig_step  # Page for creating a gig
      patch :update_create_gig_step  # Handles gig creation submission
    end
  end

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root 'home#index'

  resources :posts, only: [:index, :new, :create, :show, :edit, :update]
end
