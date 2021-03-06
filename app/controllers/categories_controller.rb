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
    @category = Category.find(params[:id])
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update(category_params)
    if @category.save
      flash[:success] = "You have successfully updated a category!"
      redirect_to categories_path
    else
      render 'new'
    end
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