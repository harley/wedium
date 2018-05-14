class ArticlesController < ApplicationController
  def index
    @articles = Article.all

    if params[:author]
      @articles = @articles.joins(:author).where(authors: {username: params[:author]})
    end
  end
end
