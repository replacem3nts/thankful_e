class SessionsController < ApplicationController
  def new
    @error = flash[:errors]
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:errors] = "Sorry, the username or password was invalid!"
      redirect_to login_path
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to goodbye_path
  end


  def about
  end

  def map
  end

  def welcome
  end

  def goodbye
    redirect_to root_path
  end
end
