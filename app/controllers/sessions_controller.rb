class SessionsController < ApplicationController
  def new
    @error = flash[:errors]
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      redirect_to user_path(@user)
    else
      flash[:errors] = "Sorry, the username or password was invalid!"
      redirect_to login_path
    end
  end
end
