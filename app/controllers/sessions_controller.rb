class SessionsController < ApplicationController

  def new
  end

  def create
    user_info = params[:sessions]

    puts params[:session]
    puts "hello"
    puts params[:sessions]

    user = User.find_by_email(user_info[:email].downcase)
    if user && user.authenticate(user_info[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome back #{user.username}!"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Invalid email or password. Please try again."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out."
    redirect_to login_path
  end

end