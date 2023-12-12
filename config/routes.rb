Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy', as: 'sign_out'
    get 'sign_in', to: 'devise/sessions#new', as: 'sign_in'
  end

  # Defines the root path route ("/")
  root 'posts#index'

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  resources :likes, only: [:create, :destroy]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
end
