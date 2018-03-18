# Serializes an instance of User

class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :image
end
