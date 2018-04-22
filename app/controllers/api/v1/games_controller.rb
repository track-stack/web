class Api::V1::GamesController < ::Api::BaseController
  before_action :doorkeeper_authorize!
  before_action :require_application!
  before_action :require_game!, only: [:show, :turn]
  before_action :require_player_in_game!, only: [:show, :turn]

  def show
    serializable = Serializable::Game.new(game: @game, viewer: current_user)
    serialized = GameSerializer.new(serializable).to_hash[:data][:attributes]
    render json: { game: serialized }
  end

  def turn
    turn = Turn.create(
      user: current_user,
      game: @game,
      stack: stack,
      answer: params[:answer],
      match: sanitize_match(params[:match])
    )

    if params[:game_over] && stack.can_end?
      stack.mark_winner!(current_user)
    end

    if turn.valid?
      opponent = @game.players.reject { |p| p == current_user }.first
      Notification::Turn.new(
        player: current_user,
        opponent: opponent
      ).send

      @game.touch
      serializable = Serializable::Game.new(game: @game.reload, viewer: current_user)
      serialized = GameSerializer.new(serializable).to_hash[:data][:attributes]
      render json: { game: serialized }
    else
      render json: { errors: turn.errors }, status: :bad_request
    end
  end

  private

  def sanitize_match(match)
    name = match["name"]
    artist = match["artist"]
    image = match["image"].last["#text"]

    { name: name, artist: artist, image: image }
  end

  def stack
    return @stack if defined?(@stack)
    @stack = Stack.find_by(id: params[:stack_id]) if params[:stack_id]
    @stack ||= @game.stacks.last
  end

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
