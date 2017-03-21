module ApplicationHelper

  def signed_in
    !session.nil? && !session[:user_id].nil?
  end

end
