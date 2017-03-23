class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

private

  def signed_in
    !session.nil? && !session[:user_id].nil?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if signed_in
  end

  def current_user?(user)
    current_user == user
  end

  def require_signin
    unless signed_in
      redirect_to signin_url, alert: "Please sign in first!" 
    end
  end

  def sign_out
    session[:user_id] = nil
  end

  helper_method :signed_in, :current_user, :current_user?
end
