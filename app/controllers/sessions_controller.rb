class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Welcome back, #{user.name}!"
    else
      flash.now[:alert] = "Invalid email/password combination."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

end