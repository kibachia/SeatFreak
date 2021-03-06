class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in

  def current_user
    User.find_by(session_token: session[:session_token])
  end

  def logged_in
    !!current_user
  end

  def login!(user)
    session[:session_token] = user.reset_session_token!
  end

  def logout
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def ensure_logged_in
    if !logged_in
      render json: ["Must be signed in"], status: 422
    end
  end
end
