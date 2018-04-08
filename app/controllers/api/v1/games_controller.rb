class Api::V1::GamesController < ::Api::BaseController
  before_action :doorkeeper_authorize!
  before_action :require_application!
  before_action :require_game!, only: [:show, :turn]
  before_action :require_player_in_game!, only: [:show, :turn]

  def show
    serializable = Serializable::Game.new(game: game, viewer: current_user)
    serialized = GameSerializer.new(serializable).to_hash[:data][:attributes]
    render json: { game: serialized }
  end

  private

  def game
  def require_game!
    includes = {stacks: [{turns: [:user]}]}
    unless @game = Game.includes(includes).find_by(id: params[:id])
      render_404
    end
  end

  def require_player_in_game!
    unless @game.user_games.map(&:user_id).include? current_user.id
      return render_404
    end
  end
end
