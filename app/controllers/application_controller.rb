class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login

  def current_user
    return nil unless session[:token];
    @current_user || @current_user = User.find_by(session_token: session[:token])
  end

  def login(user)
    user.reset_session_token!
    session[:token] = user.session_token
  end

  def logout
    user.reset_session_token!
    session[:token] = nil
  end

  def require_login
    unless !!current_user
      flash[:errors] << "You must be logged in to see that page"
      redirect_to new_session_url
  end



end
