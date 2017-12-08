module Api
  class BaseController < ActionController::API
    include ActionController::RequestForgeryProtection
    include ApiAuthenticable

    protect_from_forgery with: :exception, prepend: true

  end
end
