class Api::V1::DashboardController < ::Api::BaseController
  before_action :doorkeeper_authorize!
  before_action :require_application!

  def index
    view_model = ::Pages::IndexView.new(user: current_user)
    render json: {
      user_games: view_model.user_games,
      invites: view_model.invites
    }
  end
end
