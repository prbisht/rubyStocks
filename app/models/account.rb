class Account < ApplicationRecord
  belongs_to :user
  has_many :account_coins

  validates :currency, presence: true
end
