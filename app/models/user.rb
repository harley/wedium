class User < ActiveRecord::Base
  validates :email, :username, uniqueness: true

  has_secure_password

  def self.generate_jwt(user_id)
    JWT.encode({ id: user_id, exp: 60.days.from_now.to_i },
      Rails.application.secrets.secret_key_base)
  end

  def self.decode_jwt(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base).first
  end
end
