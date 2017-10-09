module AuthHelper
  def auth_hash
    @auth_hash ||= begin
      file = file_fixture("facebook_omniauth_hash.json").read
      json = JSON.parse(file)
      OmniAuth::AuthHash.new(json)
    end
  end

  def auth_hash_without_email
    @auth_hash ||= begin
      file = file_fixture("facebook_omniauth_hash_without_email.json").read
      json = JSON.parse(file)
      json.delete :email
      OmniAuth::AuthHash.new(json)
    end
  end
end

