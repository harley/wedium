class Article
  module Scopes
    def authored_by(username)
      joins(:author).where({ authors: { username: username }})
    end
  end
end