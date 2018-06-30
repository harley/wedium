class User < ActiveRecord::Base
  validates :email, :username, uniqueness: true
  validates :username, presence: true, allow_blank: false
  has_many :articles, dependent: :destroy

  has_secure_password

  def token
    self.class.generate_jwt(id)
  end

  def self.generate_jwt(user_id)
    JWT.encode( { id: user_id, exp: 60.days.from_now.to_i }, Rails.application.secrets.secret_key_base)
  end

  def self.decode_jwt(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base).first
  end
end
