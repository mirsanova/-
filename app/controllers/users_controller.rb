  class UsersController < ApplicationController

  before_filter :save_login_state, :only => [:new, :create]

  def new
      
      @user = User.new     
  end

   def create
      @user = User.new(user_params)

      if @user.save
        flash[:notice] = "You Signed up successfully"
        flash[:color]= "valid"
        redirect_to root_path
      else
        flash[:notice] = "Form is invalid"
        flash[:color]= "invalid"
        render "new"
      end
      
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end