# frozen_string_literal: true

module ApiExceptions
  class BaseException < StandardError
    include ActiveModel::Serialization
    attr_reader :code, :message, :title, :const

    def initialize(message = nil, code = nil, title = nil, const = nil)
      @message = message
      @code = code
      @title = title
      @const = const
    end
  end

  class INVALID_TRANSACTION_TYPE < BaseException
    def initialize(message = 'Invalid Transaction type', code = 402,
                   title = 'base', const = 'INVALID_TRANSACTION_TYPE')
      super(message, code, title, const)
    end
  end

  class PAYER_COIN_NOT_AVAILABLE_IN_ACCOUNT < BaseException
    def initialize(message = 'Payer Coin not available in account', code = 402,
                   title = 'base', const = 'PAYER_COIN_NOT_AVAILABLE_IN_ACCOUNT')
      super(message, code, title, const)
    end
  end

  class PAYEE_COIN_NOT_AVAILABLE_IN_ACCOUNT < BaseException
    def initialize(message = 'Payee Coin not available in account', code = 402,
                   title = 'base', const = 'PAYEE_COIN_NOT_AVAILABLE_IN_ACCOUNT')
      super(message, code, title, const)
    end
  end

  class COIN_NOT_AVAILABLE_IN_ACCOUNT < BaseException
    def initialize(message = 'Coin not available in account', code = 402,
                   title = 'base', const = 'COIN_NOT_AVAILABLE_IN_ACCOUNT')
      super(message, code, title, const)
    end
  end

  class INSUFFICIENT_COIN_IN_ACCOUNT < BaseException
    def initialize(message = 'Insufficient coin in account', code = 402,
                   title = 'base', const = 'INSUFFICIENT_COIN_IN_ACCOUNT')
      super(message, code, title, const)
    end
  end

  class INSUFFICIENT_BALANCE_IN_ACCOUNT < BaseException
    def initialize(message = 'Insufficient balance in account', code = 402,
                   title = 'base', const = 'INSUFFICIENT_BALANCE_IN_ACCOUNT')
      super(message, code, title, const)
    end
  end

  class ACCOUNT_NOT_FOUND < BaseException
    def initialize(message = 'Account not found', code = 404,
                   title = 'base', const = 'ACCOUNT_NOT_FOUND')
      super(message, code, title, const)
    end
  end

  class USER_NOT_FOUND < BaseException
    def initialize(message = 'User not found', code = 404,
                   title = 'base', const = 'USER_NOT_FOUND')
      super(message, code, title, const)
    end
  end

  class ACCOUNT_ID_NOT_PASSED < BaseException
    def initialize(message = 'Account id not passed', code = 402,
                   title = 'base', const = 'ACCOUNT_ID_NOT_PASSED')
      super(message, code, title, const)
    end
  end

  class CURRENCY_NOT_SUPPORTED < BaseException
    def initialize(message = 'Currency not supported', code = 402,
                   title = 'base', const = 'CURRENCY_NOT_SUPPORTED')
      super(message, code, title, const)
    end
  end

  class COIN_NOT_SUPPORTED < BaseException
    def initialize(message = 'Coin not supported', code = 402,
                   title = 'base', const = 'COIN_NOT_SUPPORTED')
      super(message, code, title, const)
    end
  end

  class ParamsInvalid < BaseException
    def initialize(message = 'Params Invalid', code = 400,
                   title = 'base', const = 'PARAMS_INVALID')
      super(message, code, title, const)
    end
  end
end
