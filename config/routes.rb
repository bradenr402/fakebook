Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy', as: 'sign_out'
    get 'sign_in', to: 'devise/sessions#new', as: 'sign_in'
  end

  # Defines the root path route ("/")
  root 'posts#index'

  resources :posts do
    resources :comments, only: %i[create destroy]
  end

  resources :likes, only: %i[create destroy]

  resources :users do
    member do
      get :following, :followers
    end
  end
  post 'users/:id/follow', to: 'users#follow', as: 'follow_user'
  post 'users/:id/unfollow', to: 'users#unfollow', as: 'unfollow_user'

  delete 'follow_requests/:id/cancel_request', to: 'follow_requests#destroy', as: 'cancel_request'

  post 'follow_requests/:id/accept', to: 'follow_requests#accept', as: 'accept_request'
  post 'follow_requests/:id/decline', to: 'follow_requests#decline', as: 'decline_request'

  get 'discover', to: 'posts#discover', as: 'discover_feed'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
end
