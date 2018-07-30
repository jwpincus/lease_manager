class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      flash[:msg] = "Welcome back, #{user.name.capitalize}!"
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:danger] = "Password or email not recognized"
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:msg] = "Succesfully Logged out"
    redirect_to '/login'
  end

end
