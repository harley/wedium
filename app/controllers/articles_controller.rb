class ArticlesController < ApplicationController
  def index
    result = {
      articles: [
        {
          title: "How to train your dragon",
          slug: "how-to-train-your-dragon-a3ho3w",
          body: "Very carefully.",
          createdAt: "2018-05-11T04:00:10.736Z",
          updatedAt: "2018-05-11T04:00:10.736Z"
        }
      ],
      articlesCount: 1
    }
    render json: result
  end
end
