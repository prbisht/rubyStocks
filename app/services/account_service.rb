class AccountService
  def initialize()
  end

  def account(params)
    account = Account.find_by(id: params[:account_id])
    raise ApiExceptions::ACCOUNT_NOT_FOUND unless account.present?
    account
  end

  def create(params)
    Account.create!(currency: params[:currency], user_id: params[:user_id])
  end

  private
end
