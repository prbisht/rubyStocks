module Api
  module V1
    class AccountsController < Api::BaseController
      # Action to get all accounts of a particular user
      def index
        # Find the user by user_id
        user = User.find_by(id: params[:user_id])

        # If the user is not found, return an error
        unless user
          render json: { success: false, error: "User not found" }, status: :not_found
          return
        end

        # Fetch all accounts associated with the user
        accounts = user.accounts

        # If no accounts are found, return a success response with an empty array
        render json: { success: true, accounts: accounts }, status: :ok
      end

      # Action to get all accounts of all users
      def all_user_accounts
        # Retrieving all accounts associated with users
        accounts = Account.all

        # Responding with JSON and sending status 200 (OK)
        render json: { success: true, accounts: accounts }, status: :ok
      end

      # Action to create a new account
      def create
        ApiParamsValidator.validate_create_account_params?(params)

        account = AccountService.new.create(params)
        render json: { success: true, account: account }, status: :created
      rescue ApiExceptions::USER_NOT_FOUND => e
        render json: { success: false, error: e.message }, status: :unprocessable_entity
      rescue ActiveRecord::RecordInvalid => e
        render json: { success: false, error: e.message }, status: :unprocessable_entity
      end
    end
  end
end
