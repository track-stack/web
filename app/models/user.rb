class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :user_games
  has_many :games, through: :user_games
  has_many :turns

  has_many :access_tokens, class_name: "Doorkeeper::AccessToken", foreign_key: :resource_owner_id

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email || random_email
      user.password = Devise.friendly_token[0,20]
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.name = auth.info.name
      user.image = auth.info.image
    end
  end

  def self.bot
    User.find_by(email: "bot@trackstack.com")
  end

  def generate_access_token(app_id)
    access_tokens.destroy_all
    access_tokens.create(application_id: app_id)
  end

  def active_access_token
    access_tokens.last
  end

  private

  def self.random_email
    name = (0...10).map { ('a'..'z').to_a[rand(26)] }.join
    "#{name}@email.com"
  end
end
