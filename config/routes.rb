Rails.application.routes.draw do
  # — Devise routes first — 
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # — Root routing, inside a Devise scope so mapping[:user] is always available — 
  devise_scope :user do
    authenticated :user do
      root to: 'posts#index', as: :authenticated_root
    end

    unauthenticated :user do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  # — Seller profile related routes — 
  get 'become_a_seller', to: 'sellers#info', as: :become_a_seller
  get 'new_seller_profile', to: 'sellers#new', as: :new_seller_profile
  post 'create_seller_profile', to: 'sellers#create', as: :create_seller_profile

  resources :sellers, only: [:show, :edit, :update] do
    member do
      get   :occupation_step
      patch :update_occupation_step
      get   :security_step
      patch :update_security_step
      get   :account
      patch :update_account
    end
  end

  # — Posts (with member routes) — 
  resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    member do
      get  :buy,              to: 'posts#buy'
      get  :contact_creator,  to: 'posts#contact_creator'
      post :send_message,     to: 'posts#send_message'
      post :submit_review,    to: 'posts#submit_review'
    end

    # Nested services under posts
    resources :services, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      # Nested orders under services
      resources :orders, only: [:new, :create]
    end
  end

  # — Gigs and nested posts — 
  resources :gigs, only: [:new, :create, :index, :show] do
    resources :posts, only: [:index, :new, :create]
  end

  # — Creator profile — 
  get 'creator/:id', to: 'creators#show', as: :creator

  # — Orders — 
  get 'orders', to: 'orders#index', as: :orders

  # — Requests and nested messages — 
  resources :requests, only: [:index, :create] do
    resources :messages, only: [:create]
  end

  # — PWA manifest — 
  get '/manifest.json', to: 'home#manifest', defaults: { format: :json }
end
