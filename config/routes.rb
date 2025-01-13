# Rails.application.routes.draw do
#   # Health check
#   get "up" => "rails/health#show", as: :rails_health_check
#
#   # API routes
#   scope 'v1' do
#     scope module: 'api/v1' do
#       # Accounts
#       resources :accounts, only: [:index, :create] do
#         resources :coins, only: [:index, :create]
#       end
#
#       # Users
#       resources :users, only: [:index, :create]
#     end
#   end
# end
Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # API routes
  scope 'v1' do
    scope module: 'api/v1' do
      # Accounts
      resources :accounts, only: [:index, :create] do
        resources :coins, only: [:index, :create]
      end

      # Users
      resources :users, only: [:index, :create]

      # Custom route for fetching accounts of a specific user
      get '/users/:user_id/accounts', to: 'accounts#index', as: :user_accounts
    end
  end
end

