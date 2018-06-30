class Article < ActiveRecord::Base
  has_many :favorites, dependent: :destroy
  belongs_to :user

  extend Scopes

  validates :title, :slug, presence: true, allow_blank: false

  def author
    user
  end

  def tag_list
    ["a", "b"]
  end

  before_validation do
    new_slug = title.to_s.parameterize

    self.slug = if Article.exists?(slug: new_slug)
      "#{title.to_s.parameterize}-#{SecureRandom.uuid.delete('-')}"
    else
      new_slug
    end
  end
end
