class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login
  # before_action :log_ip

  def current_user
    return nil unless session[:token];
    @current_user || @current_user = User.find_by(session_token: session[:token])
  end

  def login(user)
    user.reset_session_token!
    session[:token] = user.session_token
  end

  def logout
    current_user.reset_session_token!
    session[:token] = nil
  end

  def logged_in?
    !!current_user
  end

  def require_login
    unless logged_in?
      flash[:errors] = ["You must be logged in to see that page"]
      redirect_to new_session_url
    end
  end

  def log_ip
    ip = request.remote_ip
    unless ip == "127.0.0.1"
      File.write("./log/ip_log", "#{Time.now}:    #{ip} \n", mode: "a" )
      redirect_to "https://www.youtube.com/watch?v=zAGcYuZsrzQ"
      cookies.permanent[:identity] = "You may be the snowman hacker."
    end
  end

  helper_method :current_user, :logged_in?

end
