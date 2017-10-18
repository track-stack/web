class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]


  def game_invites(status = nil)
    case status
    when :received
      GameInvite.where("invitee_id = ?", id)
    when :sent
      GameInvite.where("inviter_id = ?", id)
    else
      GameInvite.where("inviter_id = ? or invitee_id = ?", id, id)
    end
  end

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

  private

  def self.random_email
    name = (0...10).map { ('a'..'z').to_a[rand(26)] }.join
    "#{name}@email.com"
  end
end
