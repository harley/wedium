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
    article = current_user.articles.build(article_params)
    article.remember_favorited(current_user)
    if article.save
      render '_article', locals: { article: article }
    else
      render json: { error: "Error: #{article.errors.full_messages.to_sentence}"}
    end
  end

  def update
    article = current_user.articles.find_by(slug: params[:id])
    if article.update(article_params)
      render '_article', locals: { article: article }
    else
      render json: { error: "Error: #{article.errors.full_messages.to_sentence}"}
    end
  end

  def destroy
    article = current_user.articles.find_by(slug: params[:id])
    if article
      article.destroy
      render json: { success: 'Article deleted.' }
    else
      render json: { error: 'Not found' }, status: 404
    end
  end

  def favorite
    article = find_user_article
    article.favorite_by!(current_user)
    article.remember_favorited(current_user)
    render '_article', locals: { article: article }
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
