class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      if session[:intended_url].nil?
        redirect_to user_path(user)
      else
        redirect_to session[:intended_url]
      end
      flash[:notice] = "Welcome back, #{user.name}!"
    else
      flash.now[:alert] = "Invalid email/password combination."
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_url, notice: "You're now signed out!"
  end

end