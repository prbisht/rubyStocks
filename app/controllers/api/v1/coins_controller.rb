module Api
  module V1
    class CoinsController < ApplicationController
      def index
        account_service = AccountService.new
        account = account_service.account(params)
        coins = account.account_coins
        render json: coins
      end

      def create
        ApiParamsValidator.validate_coin_params?(params)
        account_service = AccountService.new
        account = account_service.account(params)
        coin = account.account_coins.create!(coin_name: params[:coin_name])
        render json: coin
      end
    end
  end
end
