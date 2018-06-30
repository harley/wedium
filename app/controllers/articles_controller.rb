class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    @articles = @articles.authored_by(params[:author]) if params[:author]
    @articles = @articles.favorited_by(params[:favorited]) if params[:favorited]
  end

  def show
    @article = Article.find_by(slug: params[:id])
  end
end
