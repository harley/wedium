class Article
  module Scopes
    def authored_by(username)
      joins(:user).where(users: { username: username })
    end

    def favorited_by(username)
      joins(:favorites).where(favorites: { user: User.find_by(username: username) })
    end
  end
end