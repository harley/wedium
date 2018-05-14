class Article < ActiveRecord::Base
  has_many :favorites, dependent: :destroy
  belongs_to :author

  extend Scopes

  validates :title, :slug, presence: true, allow_blank: false

  def tag_list
    ["a", "b"]
  end

  before_validation do
    self.slug = "#{title.to_s.parameterize}-#{SecureRandom.uuid.gsub('-','')}"
  end
end
