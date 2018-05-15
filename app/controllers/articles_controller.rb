class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user_or_admin, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    require_user
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article was created successfully"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:success] = "Article was successfully deleted"
    redirect_to articles_path
  end

  private
    def article_params
      return params.require(:article).permit(:title, :description)
    end

    def set_article
      @article = Article.find params[:id]
    end

    def require_same_user_or_admin
      if current_user != @article.user && !current_user.admin
        redirect_to articles_path
      end
    end
end