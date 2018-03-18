class Api::V1::DashboardController < ::Api::BaseController
  before_action :doorkeeper_authorize!
  before_action :require_application!

  def index
    view_model = ::Pages::IndexView.new(user: current_user)
    game_previews = view_model.active_game_previews.map do |preview|
      hash = DashboardGamePreviewSerializer.new(preview).to_hash
      hash[:data][:attributes]
    end

    render json: {
      active_game_previews: game_previews,
      invites: view_model.invites
    }
  end
end
