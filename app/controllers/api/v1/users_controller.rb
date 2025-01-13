module Api::V1
  class UsersController < Api::BaseController

=begin
    before_action only: [:index] do
      ApiParamsValidator.validate_users_index_params?(params)
    end
=end

    def index
      user = UserService.new.user_accounts(params)
      render json: { success: true, user: user }, status: :created
    end

    def create
      user = UserService.new.create_account(params)
      render json: { success: true, user: user }, status: :created
    rescue ActiveRecord::RecordInvalid => exception
      raise ApiExceptions::ParamsInvalid.new(exception.message)
    end
  end
end
