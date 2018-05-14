class Article
  module Scopes
    def authored_by(username)
      joins(:author).where({ authors: { username: username }})
    end

    def favorited_by(username)
      joins(:favorites).where(favorites: { user: User.where(username: username) })
    end
  end
end