module ApiAuthenticable
  def current_user
    @current_user ||= User.find_by auth_token: request.headers['Authorization']
  end

  def authenticate_with_token!
    return if user_signed_in?
    render json: { errors: 'Not authenticated' }, status: :unauthorized
  end

  def user_signed_in?
    current_user.present?
  end

  def log_in user
    session[:user_id] = user.id
  end

  def log_out
    session.delete :user_id
  end
end
