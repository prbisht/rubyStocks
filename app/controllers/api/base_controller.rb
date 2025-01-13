class Api:: BaseController < ApplicationController

  rescue_from ApiExceptions::BaseException,
              with: :render_error_response
  def render_error_response(error)
    error_hash = {
      "success": false,
      "error_const": error.const,
      "errors": [
        {
          'title': error.title,
          'message': error.message
        }
      ]
    }
    render json: error_hash, status: error.code
  end
end
