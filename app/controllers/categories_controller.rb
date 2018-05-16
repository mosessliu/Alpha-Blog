class CategoriesController < ApplicationController

  before_action :require_admin, except: [:index, :show]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "You have created a new category!"
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def show
  end


  private 
    def category_params
      return params.require(:category).permit(:name)
    end

    def require_admin
      if !logged_in? || !current_user.admin
        redirect_to categories_path
      end
    end

end