class CoinService
  SUPPORTED_COINS = ['BTC', 'ETH'].freeze

  def account_coins(account_id)
    account = Account.find_by(id: account_id)
    raise ApiExceptions::ACCOUNT_NOT_FOUND unless account.present?
    account.account_coins
  end

  def create(params)
    account = Account.find_by(id: params[:account_id])
    raise ApiExceptions::ACCOUNT_NOT_FOUND unless account.present?

    unless SUPPORTED_COINS.include?(params[:coin_name].upcase)
      raise ApiExceptions::COIN_NOT_SUPPORTED
    end

    # Don't create duplicate coins for an account
    existing_coin = account.account_coins.find_by(coin_name: params[:coin_name].upcase)
    return existing_coin if existing_coin.present?

    AccountCoin.create!(
      account_id: params[:account_id],
      coin_name: params[:coin_name].upcase
    )
  end
end
