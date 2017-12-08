module Api
  class BaseController < ActionController::API
    protect_from_forgery with: :null_session

    include ApiAuthenticable
  end
end
