class Article < ActiveRecord::Base
  belongs_to :author

  extend Scopes

  validates :title, :slug, presence: true, allow_blank: false

  def tag_list
    ["a", "b"]
  end
end
