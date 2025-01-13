class AccountCoin < ApplicationRecord
  belongs_to :account

  validates :coin_name, presence: true
end

