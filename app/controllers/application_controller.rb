class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  
  def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else
      @current_user = nil
    end
    @current_user
  end

  def user_signed_in?
    if !current_user
      flash[:danger] = "You must be signed in to do that!"
      redirect_to root_path
    end
  end
  
end
