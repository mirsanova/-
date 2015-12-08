class SessionsController < ApplicationController
 
  def create  
    
  	@user = User.find_by_email(params[:session][:email].downcase)

    if @user && @user.authenticate(params[:session][:password])
      sign_in @user
  		

  		flash.now[:succes] = "Добро пожаловать, #{@user.name}"

  		redirect_to root_path
      
  	else
  		flash.now[:danger] = 'Неправильно введен e-mail или пароль'
  		render 'new'
  	end
  end

	def destroy
		sign_out 
		redirect_to root_path  		
	end  
end
