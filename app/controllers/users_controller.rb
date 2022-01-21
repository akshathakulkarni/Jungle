class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      puts "user name = #{@user.name}"
      session[:user_id] = @user.id
      redirect_to [:products], notice: 'New user created!'
    else
      redirect_to [:users]
    end
  end

  private 

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
