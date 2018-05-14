class Author < ActiveRecord::Base
  validates :username, presence: true, allow_blank: false
end
