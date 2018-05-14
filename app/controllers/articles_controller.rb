class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    @articles = @articles.authored_by(params[:author]) if params[:author]
  end
end
