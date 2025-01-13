class UserService

  def initialize() end

  def user_accounts(params)
    user = User.find_by(id: params[:user_id])
    raise ApiExceptions::USER_NOT_FOUND unless user.present?
    user
  end


  def create_account(params)
    User.create!(email: params[:email])
  end

  private

  def fetch_accounts(user, params)
    accounts = Account.where(user_id: params[:user_id])
    accounts = [] unless accounts.present?
    accounts = accounts

    json = user.as_json
    json.merge(accounts: accounts.as_json)
  end
end
