module Api::V1
  class UsersController < Api::BaseController
    def index
      if params[:user_id].present?
        user = UserService.new.user_accounts(params)
        render json: { success: true, user: user }, status: :ok
      else
        users = User.all
        render json: { success: true, users: users }, status: :ok
      end
    end

    def create
      user = UserService.new.create_account(params)
      render json: { success: true, user: user }, status: :created
    rescue ActiveRecord::RecordInvalid => exception
      raise ApiExceptions::ParamsInvalid.new(exception.message)
    end
  end
end
