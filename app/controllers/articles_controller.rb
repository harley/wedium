class ArticlesController < ApplicationController
  before_action :require_user, only: [:create, :destroy]

  def index
    @articles = Article.all
    @articles = @articles.authored_by(params[:author]) if params[:author]
    @articles = @articles.favorited_by(params[:favorited]) if params[:favorited]
  end

  def show
    @article = Article.find_by(slug: params[:id])
    @article.remember_favorited(current_user)
  end

  def create
  end

  def update
  end

  def destroy
  end

  def favorite
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :body, :tag_list)
  end

  def find_user_article
    article = current_user.articles.find_by(slug: params[:id])
    unless article
      render json: { error: 'Not found' }, status: 404
    end
    article
  end
end
