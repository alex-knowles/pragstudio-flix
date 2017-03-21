class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.authenticate(params[:email], params[:password])
      redirect_to user_path(user), notice: "Welcome back, #{user.name}!"
    else
      flash.now[:alert] = "Invalid email/password combination."
      render :new
    end
  end

end