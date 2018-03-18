class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :image
end
