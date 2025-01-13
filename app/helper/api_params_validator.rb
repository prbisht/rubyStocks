# frozen_string_literal: true

require 'json-schema'

class ApiParamsValidator
  class << self

    def validate_transaction_params?(params)
      transaction_type = params[:transaction_type]

      case transaction_type
      when Constants::Transaction_Type::BUY, Constants::Transaction_Type::SELL
        errors = JSON::Validator.fully_validate(transaction_schema, params)
      when Constants::Transaction_Type::EXCHANGE
        errors = JSON::Validator.fully_validate(transaction_exchange_schema, params)
      end
      raise ApiExceptions::ParamsInvalid, errors.join(', ') unless errors.count.zero?
    end

    def validate_transactions_index_params?(params)
      raise ApiExceptions::ACCOUNT_ID_NOT_PASSED unless params[:account_id].present?
    end

    def validate_accounts_index_params?(params)
      raise ApiExceptions::ACCOUNT_ID_NOT_PASSED unless params[:account_id].present?
    end

    def validate_users_index_params?(params)
      raise ApiExceptions::ACCOUNT_ID_NOT_PASSED unless params[:user_id].present?
    end

  end
end
