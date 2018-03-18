class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :score

  def score
    i_score = @instance_options[:score]
    i_score ? i_score.to_i : nil
  end
end
