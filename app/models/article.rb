class Article < ActiveRecord::Base
  belongs_to :author

  scope :authored_by, ->(username) { joins(:author).where({ authors: { username: username }}) }

  def tag_list
    ["a", "b"]
  end
end
