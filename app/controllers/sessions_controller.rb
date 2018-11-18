class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by_email_and_role(params[:email], params[:role])
    if user && user.authenticate(params[:password])
      flash[:success] = "Welcome back, #{user.name}!"
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:danger] = "Password or email not recognized"
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Succesfully Logged out"
    redirect_to '/login'
  end

end
