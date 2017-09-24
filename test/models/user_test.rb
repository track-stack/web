require 'test_helper'


class UserTest < ActiveSupport::TestCase
  def auth_hash
    @auth_hash ||= begin
      file_path = Rails.root.join("test", "fixtures", "facebook_omniauth_hash.json")
      file = File.read(file_path)
      json = JSON.parse(file)
      OmniAuth::AuthHash.new(json)
    end
  end

  test "creates a new record" do
    user = User.from_omniauth(auth_hash)

    assert user
    assert user.persisted?
    assert_instance_of(User, user)
  end
end
