class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :create, :turn]
  before_action :validate_viewer_in_game, only: [:show]
  skip_before_action :verify_authenticity_token, only: [:turn]

  def new
  end

  def show
    if request.xhr?
      render json: { game: GameSerializer.new(game, viewer: current_user) }
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

  def turn
    turn = Turn.create(user_id: current_user.id, game_id: game.id, answer: params[:answer])
    if turn.valid?
      render json: { game: GameSerializer.new(game, viewer: current_user) }
    else
      flash[:error] = "❌ Your answer was not submitted. Please try again."
      return redirect_back(fallback_location: game_path(game))
    end
  end

  private

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
    @game ||= Game.find_by(id: params[:id])
  end

  def invitee
    User.find_by(uid: params[:uid])
  end
end
