class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :create, :turn]
  before_action :validate_viewer_in_game, only: [:show]
  skip_before_action :verify_authenticity_token, only: [:turn]

  def new
  end

  def show
    if request.xhr?
      serializable = Serializable::Game.new(game: game, viewer: current_user)
      serialized = GameSerializer.new(serializable).to_hash[:data][:attributes]
      render json: { game: serialized }
    else
      view = Games::ShowView.new(user: current_user, game: game)
      render "games/show", locals: { view: view }
    end
  end

  def create
    if game = Game.from(user: current_user, invitee: invitee)
      redirect_to game_path(game)
    else
      flash[:error] = "There was a problem creating your game 😱"
      redirect_back fallback_location: "/games/new"
    end
  end

  # TODO: this method is a mess
  def turn
    turn = Turn.create(
      user: current_user,
      game: game,
      stack: stack,
      answer: params[:answer],
      match: sanitize_match(params[:match])
    )

    if params[:game_over] && stack.can_end?
      stack.mark_winner!(current_user)
    end

    if turn.valid?
      serializable = Serializable::Game.new(game: game.reload, viewer: current_user)
      serialized = GameSerializer.new(serializable).to_hash[:data][:attributes]
      render json: { game: serialized }
    else
      flash[:error] = "❌ Your answer was not submitted. Please try again."
      return redirect_back(fallback_location: game_path(game))
    end
  end

  def new_stack
    game.stacks.create
    redirect_to game_path(game)
  end

  private

  def sanitize_match(match)
    name = match["name"]
    artist = match["artist"]
    image = match["image"].last["#text"]

    { name: name, artist: artist, image: image }
  end

  def validate_viewer_in_game
    unless game
      flash[:error] = "❌ We can't find the game you're looking for"
      return redirect_back(fallback_location: root_url)
    end

    user_ids = UserGame.where(game_id: game.id).pluck(:user_id)
    unless user_ids.include?(current_user.id)
      flash[:error] = "❌ You don't belong in that game"
      return redirect_back(fallback_location: root_url)
    end
  end

  def game
    includes = {stacks: [{turns: [:user]}]}
    @game ||= Game.includes(includes).find_by(id: params[:id])
  end

  def stack
    return @stack if defined?(@stack)
    @stack = Stack.find_by(id: params[:stack_id]) if params[:stack_id]
    @stack ||= game.stacks.last
  end

  def invitee
    User.find_by(uid: params[:uid])
  end
end
