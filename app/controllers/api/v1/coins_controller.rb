module Api
  module V1
    class CoinsController < ApplicationController
      before_action :set_account, only: [:index, :create, :show]

      def index
        account_service = AccountService.new
        account = account_service.account(params)
        coins = account.account_coins
        render json: coins
      end

      def create
        coin = @account.account_coins.find_by(coin_name: params[:coin_name])

        if coin
          coin.update(quantity: coin.quantity + params[:quantity].to_d)
          render json: { success: true, coin: coin }, status: :ok
        else
          new_coin = @account.account_coins.create(coin_name: params[:coin_name], quantity: params[:quantity])
          render json: { success: true, coin: new_coin }, status: :created
        end
      end

      # Show action to get a specific coin
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
        @account = Account.find(params[:account_id])
      rescue ActiveRecord::RecordNotFound
        render json: { success: false, error: "Account not found" }, status: :not_found
      end
    end
  end
end
