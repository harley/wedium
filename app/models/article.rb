class Article < ActiveRecord::Base
  belongs_to :author
  extend Scopes

  def tag_list
    ["a", "b"]
  end
end
