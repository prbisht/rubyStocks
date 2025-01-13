module Api
  module V1
    class CoinsController < ApplicationController
      before_action :set_account, only: [:index, :create, :show]

      # Action to get all coins associated with the account
      def index
        account_service = AccountService.new
        account = account_service.account(params)
        coins = account.account_coins

        # Returning success with empty array if no coins are found
        render json: { success: true, coins: coins }, status: :ok
      end

      # Action to create a new coin or update an existing coin's quantity
      def create
        # Fetch the coin by coin_name
        coin = @account.account_coins.find_by(coin_name: params[:coin])

        if coin
          # Update coin quantity if it exists
          coin.update(quantity: coin.quantity + params[:quantity].to_d)
          render json: { success: true, coin: coin }, status: :ok
        else
          # Create a new coin if it doesn't exist
          new_coin = @account.account_coins.create(coin_name: params[:coin], quantity: params[:quantity].to_d)

          # Check if the new coin was successfully created
          if new_coin.persisted?
            render json: { success: true, coin: new_coin }, status: :created
          else
            render json: { success: false, error: 'Failed to create coin' }, status: :unprocessable_entity
          end
        end
      end


      # Action to get a specific coin associated with the account
      def show
        coin = @account.account_coins.find_by(coin_name: params[:coin_name])

        if coin
          render json: { success: true, coin: { name: coin.coin_name, quantity: coin.quantity } }, status: :ok
        else
          # Return success: false with an error message if the coin is not found
          render json: { success: false, error: "Coin not found" }, status: :not_found
        end
      end

      private

      # Set the account based on the account_id parameter
      def set_account
        @account = Account.find(params[:account_id])
      rescue ActiveRecord::RecordNotFound
        render json: { success: false, error: "Account not found" }, status: :not_found
      end
    end
  end
end
