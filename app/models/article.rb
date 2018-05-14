class Article < ActiveRecord::Base
  belongs_to :author

  def tag_list
    ["a", "b"]
  end
end
