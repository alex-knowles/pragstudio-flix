module ApplicationHelper

  def signed_in
    !session.nil? && !session[:user_id].nil?
  end

  def current_user
    User.find(session[:user_id]) if signed_in
  end

end
