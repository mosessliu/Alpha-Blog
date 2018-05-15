class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the alpha blog!"
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @user.update(user_params)
    if @user.save
      flash[:success] = "You have changed your information!"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 9)
  end

  def destroy
    user = @user
    @user.destroy
    flash[:danger] = "#{user.username} and all his/her articles have been deleted"
    @users = User.paginate(page: params[:page], per_page: 9)
    render 'index'
  end

  private
    def user_params
      return params.require(:user).permit(:username, :email, :password)
    end

    def set_user
      @user = User.find(params[:id])
    end
    
    def require_same_user
      if !logged_in?
        redirect_to root_path
      elsif current_user != @user
        redirect_to user_path(current_user)
      end
    end

    def require_admin
      if !logged_in? || !current_user.admin
        redirect_to users_path
      end
    end
end
