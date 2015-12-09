class ApplicationController < ActionController::Base
   
  protect_from_forgery with: :exception  
  helper_method :current_user, :signed_in?

  def current_user
     @current_user ||= session[:user_id].present? && User.find_by_id(session[:user_id])

  end

  def signed_in?
    !!current_user
  end

  def must_login
    if !signed_in?
      flash[:danger] = "Пожалуйста, зарегистрируйтесь или зайдите в свой аккаунт!"
      redirect_to login_path
    end
  end

  def authenticate_user
    unless session[:user_id]
      redirect_to login_path
      return false
    else
      @current_user = User.find session[:user_id] 
      return true
    end
  end


  def save_login_state
    if session[:user_id] 
      redirect_to root_path
      return false
    else
      return true
    end
  end
end