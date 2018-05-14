class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :article, counter_cache: true

  validates :user, :article, presence: true
end
