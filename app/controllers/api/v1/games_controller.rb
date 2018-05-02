class Api::V1::GamesController < ::Api::BaseController
  before_action :doorkeeper_authorize!
  before_action :require_application!
  before_action :require_game!, only: [:show, :turn, :new_stack]
  before_action :require_player_in_game!, only: [:show, :turn, :new_stack]
  before_action :require_invitee, only: [:create]

  def show
    serializable = Serializable::Game.new(game: @game, viewer: current_user)
    serialized = GameSerializer.new(serializable).to_hash[:data][:attributes]
    render json: { game: serialized }
  end

  def create
    if game = Game.from(user: current_user, invitee: invitee)
      serializable = Serializable::Game.new(game: game, viewer: current_user)
      serialized = GameSerializer.new(serializable).to_hash[:data][:attributes]
      render json: { game: serialized }
    else
      flash[:error] = "There was a problem creating your game 😱"
      redirect_back fallback_location: "/games/new"
    end
  end

  def turn
    turn = Turn.create(
      user: current_user,
      game: @game,
      stack: stack,
      answer: params[:answer],
      match: sanitize_match(params[:match])
    )

    if turn.valid?
      opponent = @game.players.reject { |p| p == current_user }.first

      if params[:game_over] && stack.can_end?
        stack.mark_winner!(current_user)
      else
        Notification::Turn.new(
          player: current_user,
          opponent: opponent
        ).send
      end


      @game.touch
      serializable = Serializable::Game.new(game: @game.reload, viewer: current_user)
      serialized = GameSerializer.new(serializable).to_hash[:data][:attributes]
      render json: { game: serialized }
    else
      render json: { errors: turn.errors }, status: :bad_request
    end
  end

  def new_stack
    @game.stacks.create
    serializable = Serializable::Game.new(game: @game.reload, viewer: current_user)
    serialized = GameSerializer.new(serializable).to_hash[:data][:attributes]
    render json: { game: serialized }
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

  def require_invitee
    return render_404 unless invitee
  end

  def invitee
    @invitee ||= User.find_by(uid: params[:uid])
  end
end
