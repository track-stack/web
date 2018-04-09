class Api::V1::DashboardController < ::Api::BaseController
  before_action :doorkeeper_authorize!
  before_action :require_application!

  def index
    view_model = ::Pages::IndexView.new(user: current_user)
    game_previews = view_model.active_game_previews
    formatted_previews = sorted_and_grouped_previews(game_previews)
    formatted_previews.each do |key, previews|
      formatted_previews[key] = previews.map do |preview|
        hash = DashboardGamePreviewSerializer.new(preview).to_hash
        hash[:data][:attributes]
      end
    end

    render json: {
      active_game_previews: formatted_previews,
      invites: view_model.invites
    }
  end

  def sorted_and_grouped_previews(previews)
    sorted = sorted_previews(previews)
    grouped_previews(sorted)
  end

  def grouped_previews(previews)
    grouped = previews.group_by do |preview|
      preview.viewers_turn? ? "Your turn" : "Their turn"
    end
    grouped["Your turn"] ||= []
    grouped["Their turn"] ||= []
    grouped
  end

  def sorted_previews(previews)
    previews.sort do |left, right|
      right.updated_at <=> left.updated_at
    end
  end
end
