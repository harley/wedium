class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    @articles = @articles.authored_by(params[:author]) if params[:author]
    @articles = @articles.favorited_by(params[:favorited]) if params[:favorited]
  end

  def show
    @article = Article.find_by(slug: params[:id])
  end

  def create
    authenticate_user
    article = current_user.articles.build(article_params)
    if article.save
      render 'create', locals: { article: article }
    else
      render json: { error: "Error: #{article.errors.full_messages.to_sentence}"}
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :body, :tag_list)
  end
end
