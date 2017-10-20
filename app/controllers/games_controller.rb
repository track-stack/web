class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :create]
  before_action :validate_viewer_in_game, only: [:show]

  def new
  end

  def show
    view = Games::ShowView.new(user: current_user, game: game)

    if request.xhr?
      render json: { game: GameSerializer.new(game, viewer: current_user) }
    else
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
