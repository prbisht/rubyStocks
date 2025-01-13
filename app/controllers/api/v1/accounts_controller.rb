module Api::V1
  class AccountsController < Api::BaseController


=begin
    before_action only: [:index] do
      ApiParamsValidator.validate_accounts_index_params?(params)
    end
=end

    def index
      account = AccountService.new.account(params)
      render json: { success: true, account: account }, status: :created
    end

    def create
      account = AccountService.new.create(params)
      render json: { success: true, account: account }, status: :created
    rescue ActiveRecord::RecordInvalid => e
      render json: { success: false, error: e.message }, status: :unprocessable_entity
    end
  end
end
