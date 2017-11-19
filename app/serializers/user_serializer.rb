class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :score

  def score 
    @instance_options[:score].to_i
  end
end
