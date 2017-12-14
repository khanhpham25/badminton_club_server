module Api
  class BaseController < ActionController::API
    include ActionController::RequestForgeryProtection
    include ApiAuthenticable

    protect_from_forgery with: :null_session
  end
end
