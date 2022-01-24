class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    puts "From session controller = #{@user.name}"
    if @user && @user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = @user.id
      puts "session id = #{session[:user_id]}"
      redirect_to [:products]
    else
    # If user's login doesn't work, send them back to the login form.
      redirect_to [:new_session]
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to [:new_session]
  end

end
