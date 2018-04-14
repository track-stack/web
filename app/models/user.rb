class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :user_games
  has_many :games, through: :user_games
  has_many :turns

  has_many :access_tokens, class_name: "Doorkeeper::AccessToken", foreign_key: :resource_owner_id
  has_many :devices

  def self.from_omniauth(auth)
    instance = where(provider: auth.provider, uid: auth.uid).first_or_create
    if instance.new_record?
      instance.email = auth.info.email || random_email
      instance.password = Devise.friendly_token[0,20]
      instance.name = auth.info.name
    end
    instance.image = auth.info.image
    instance.oauth_token = auth.credentials.token
    instance.oauth_expires_at = Time.at(auth.credentials.expires_at)

    instance.save
    instance
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
