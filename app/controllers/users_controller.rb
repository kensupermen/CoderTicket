class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create user_params 
    if @user.persisted?
      session[:user_id] = @user.id
      flash[:success] = "Registered successfully"
      redirect_to root_path
    else
      flash.now[:error] = "Error: #{@user.errors.full_messages.to_s}"
      render 'new'
    end
  end

  def index
  end

   private 

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
