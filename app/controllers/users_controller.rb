class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the alpha blog!"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:success] = "You have changed your information!"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
    def user_params
      return params.require(:user).permit(:username, :email, :password)
    end

end
