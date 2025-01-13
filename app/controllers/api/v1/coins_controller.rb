module Api
  module V1
    class CoinsController < ApplicationController
      before_action :set_account, only: [:index, :create, :show]
      before_action :validate_create_params, only: [:create]

      # Action to get all coins associated with the account
      def index
        account_service = AccountService.new
        account = account_service.account(params)
        coins = account.account_coins

        render json: { success: true, coins: coins }, status: :ok
      end

      # Action to create a new coin or update an existing coin's quantity
      def create
        coin = @account.account_coins.find_by(coin_name: params[:coin])

        if coin
          # Update coin quantity if it exists
          updated_quantity = coin.quantity + params[:quantity].to_d
          coin.update(quantity: updated_quantity)
          render json: { success: true, coin: { name: coin.coin_name, quantity: coin.quantity } }, status: :ok
        else
          # Create a new coin if it doesn't exist
          new_coin = @account.account_coins.create(coin_name: params[:coin], quantity: params[:quantity].to_d)

          if new_coin.persisted?
            render json: { success: true, coin: { name: new_coin.coin_name, quantity: new_coin.quantity } }, status: :created
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
          render json: { success: false, error: "Coin not found" }, status: :not_found
        end
      end

      private

      def set_account
        @account = Account.find_by(id: params[:account_id])
        raise ApiExceptions::ACCOUNT_NOT_FOUND unless @account
      rescue ActiveRecord::RecordNotFound
        render json: { success: false, error: 'Account not found' }, status: :not_found
      end

      def validate_create_params
        ApiParamsValidator.validate_coin_params?(params)
        raise ApiExceptions::COIN_NOT_SUPPORTED if !['BTC', 'ETH', 'LTC'].include?(params[:coin].upcase)
        if params[:quantity].blank? || params[:quantity].to_d <= 0
          raise ApiExceptions::ParamsInvalid, 'Quantity must be greater than 0'
        end
      end
    end
  end
end
