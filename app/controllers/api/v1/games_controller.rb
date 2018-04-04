class Api::V1::GamesController < ::Api::BaseController
  before_action :doorkeeper_authorize!
  before_action :require_application!

  def show
    serializable = Serializable::Game.new(game: game, viewer: current_user)
    serialized = GameSerializer.new(serializable).to_hash[:data][:attributes]
    render json: { game: serialized }
  end

  private

  def game
    includes = {stacks: [{turns: [:user]}]}
    @game ||= Game.includes(includes).find_by(id: params[:id])
  end
end
