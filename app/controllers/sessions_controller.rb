class SessionsController < ApplicationController
  before_filter :save_login_state, only: [:new, :create]

  def create  
    @user = User.find_by_email(params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      current_user

      flash.now[:succes] = "Добро пожаловать"
      redirect_to root_path
    else
      flash.now[:danger] = 'Неправильно введен e-mail или пароль'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil 
    redirect_to root_path
  end  
end
