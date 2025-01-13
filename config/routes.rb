Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # API routes
  scope 'api/v1' do
    scope module: 'api/v1' do
      # Accounts
      resources :accounts, only: [:index, :create] do
        resources :coins, only: [:index, :create]
        get 'coins/:coin_name', to: 'coins#show', as: :coin
      end

      # Users
      resources :users, only: [:index, :create]

      get '/users/:user_id/accounts', to: 'accounts#index', as: :user_accounts
      # Custom route for fetching all user accounts (GET)
      get '/accounts/all_user_accounts', to: 'accounts#all_user_accounts', as: :all_user_accounts
    end
  end
end
